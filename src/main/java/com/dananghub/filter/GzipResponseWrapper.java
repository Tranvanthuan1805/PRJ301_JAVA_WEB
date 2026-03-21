package com.dananghub.filter;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.WriteListener;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletResponseWrapper;
import java.io.*;
import java.util.zip.GZIPOutputStream;

/**
 * Response wrapper that applies GZIP compression to the output.
 */
public class GzipResponseWrapper extends HttpServletResponseWrapper {

    private ServletOutputStream servletOutputStream;
    private PrintWriter printWriter;
    private ByteArrayOutputStream baos;

    public GzipResponseWrapper(HttpServletResponse response) {
        super(response);
        this.baos = new ByteArrayOutputStream();
    }

    @Override
    public ServletOutputStream getOutputStream() throws IOException {
        if (printWriter != null) {
            throw new IllegalStateException("getWriter() already called");
        }
        if (servletOutputStream == null) {
            servletOutputStream = new ServletOutputStream() {
                @Override
                public void write(int b) throws IOException {
                    baos.write(b);
                }

                @Override
                public void write(byte[] b, int off, int len) throws IOException {
                    baos.write(b, off, len);
                }

                @Override
                public boolean isReady() {
                    return true;
                }

                @Override
                public void setWriteListener(WriteListener writeListener) {
                }
            };
        }
        return servletOutputStream;
    }

    @Override
    public PrintWriter getWriter() throws IOException {
        if (servletOutputStream != null) {
            throw new IllegalStateException("getOutputStream() already called");
        }
        if (printWriter == null) {
            // Luôn dùng UTF-8 — tránh lỗi khi charset chưa được set lúc getWriter() được
            // gọi
            printWriter = new PrintWriter(new OutputStreamWriter(baos, java.nio.charset.StandardCharsets.UTF_8));
        }
        return printWriter;
    }

    public void finish() throws IOException {
        if (printWriter != null) {
            printWriter.flush();
        }
        if (servletOutputStream != null) {
            servletOutputStream.flush();
        }

        byte[] bytes = baos.toByteArray();

        // Only compress if content is > 256 bytes (don't compress tiny responses)
        if (bytes.length > 256) {
            ByteArrayOutputStream compressed = new ByteArrayOutputStream();
            try (GZIPOutputStream gz = new GZIPOutputStream(compressed)) {
                gz.write(bytes);
            }

            byte[] compressedBytes = compressed.toByteArray();

            // Only use compressed version if it's actually smaller
            if (compressedBytes.length < bytes.length) {
                getResponse().setContentLength(compressedBytes.length);
                ((HttpServletResponse) getResponse()).setHeader("Content-Encoding", "gzip");
                ((HttpServletResponse) getResponse()).setHeader("Vary", "Accept-Encoding");
                getResponse().getOutputStream().write(compressedBytes);
                return;
            }
        }

        // Fallback: write uncompressed
        getResponse().setContentLength(bytes.length);
        getResponse().getOutputStream().write(bytes);
    }

    @Override
    public void setContentLength(int len) {
        // Don't set content length — we'll set it in finish()
    }

    @Override
    public void setContentLengthLong(long len) {
        // Don't set content length — we'll set it in finish()
    }
}
