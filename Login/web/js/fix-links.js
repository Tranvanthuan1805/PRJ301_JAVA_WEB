// Fix all TravelBooking links to work with Login context
document.addEventListener('DOMContentLoaded', function() {
    // Fix all links
    document.querySelectorAll('a[href*="/TravelBooking/"]').forEach(link => {
        let href = link.getAttribute('href');
        href = href.replace('/TravelBooking/', '');
        link.setAttribute('href', href);
    });
    
    // Fix onclick handlers
    document.querySelectorAll('[onclick*="/TravelBooking/"]').forEach(elem => {
        let onclick = elem.getAttribute('onclick');
        onclick = onclick.replace(/\/TravelBooking\//g, '');
        elem.setAttribute('onclick', onclick);
    });
});
