import os
import re

def update_file(path, replacements):
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    for pattern, replacement in replacements:
        content = re.sub(pattern, replacement, content)
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

replacements_entity = [
    (r'package model;', 'package model.entity;'),
]

replacements_dao = [
    (r'package dao;', 'package model.dao;'),
    (r'import model\.', 'import model.entity.'),
]

replacements_controller = [
    (r'import dao\.', 'import model.dao.'),
    (r'import model\.', 'import model.entity.'),
]

# Update entities
entity_dir = 'src/main/java/model/entity'
for f in os.listdir(entity_dir):
    if f.endswith('.java'):
        update_file(os.path.join(entity_dir, f), replacements_entity)

# Update DAOs
dao_dir = 'src/main/java/model/dao'
for f in os.listdir(dao_dir):
    if f.endswith('.java'):
        update_file(os.path.join(dao_dir, f), replacements_dao)

# Update Controllers
for root, dirs, files in os.walk('src/main/java/controller'):
    for f in files:
        if f.endswith('.java'):
            update_file(os.path.join(root, f), replacements_controller)

print("Packages and imports updated successfully.")
