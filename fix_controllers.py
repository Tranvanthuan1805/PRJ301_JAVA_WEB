import os
import re

def update_file(path, replacements):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for pattern, replacement in replacements:
        content = re.sub(pattern, replacement, content)
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

replacements = [
    (r'package controller\.[a-z]+;', 'package controller;'),
]

controller_dir = 'src/main/java/controller'
for f in os.listdir(controller_dir):
    if f.endswith('.java'):
        update_file(os.path.join(controller_dir, f), replacements)

print("Controller packages updated.")
