import pytest
from corp_system.controllers.structure_manager import StructureManager


def test_equalize_role_1div_empty(client, new_user):
    
    
    department1 = StructureManager.create_department(title="test_department")
   
    division = StructureManager.create_division(title="test_division", department=department1)
    

    
    division.member_role.assign(new_user)
   

    
    StructureManager.equalize_roles(new_user)
    
    assert division.get_weight(new_user) == 100
    
def test_equalize_role_2div_empty(client, new_user):
    
    
    department1 = StructureManager.create_department(title="test_department")
    department2 = StructureManager.create_department(title="test_department2")
    division = StructureManager.create_division(title="test_division", department=department1)
    division2 = StructureManager.create_division(title="test_division2", department=department2)

    
    division.member_role.assign(new_user)
    division2.member_role.assign(new_user)

    
    StructureManager.equalize_roles(new_user)
    
    assert division.get_weight(new_user) == 50
    assert division2.get_weight(new_user) == 50


def test_equalize_role_3div_empty(client, new_user):
    
    
    department1 = StructureManager.create_department(title="test_department")
    department2 = StructureManager.create_department(title="test_department2")
    division = StructureManager.create_division(title="test_division", department=department1)
    division2 = StructureManager.create_division(title="test_division2", department=department2)
    division3 = StructureManager.create_division(title="test_division3", department=department2)

    
    division.member_role.assign(new_user)
    division2.member_role.assign(new_user)
    division3.member_role.assign(new_user)
    
    StructureManager.equalize_roles(new_user)
    
    assert division.get_weight(new_user) == 34
    assert division2.get_weight(new_user) == 33
    assert division3.get_weight(new_user) == 33
    
def test_equalize_role_1div_not_empty(client, new_user):
    
    
    department1 = StructureManager.create_department(title="test_department")
   
    division = StructureManager.create_division(title="test_division", department=department1)
    

    
    division.member_role.assign(new_user)
    division.set_weight(new_user, 95)
   

    
    StructureManager.equalize_roles(new_user)
    
    assert division.get_weight(new_user) == 100

def test_equalize_role_2div_not_empty(client, new_user):
    
    
    department1 = StructureManager.create_department(title="test_department")
    department2 = StructureManager.create_department(title="test_department2")
    division = StructureManager.create_division(title="test_division", department=department1)
    division2 = StructureManager.create_division(title="test_division2", department=department2)

    
    division.member_role.assign(new_user)
    division2.member_role.assign(new_user)
    
    division.set_weight(new_user, 100)
    division2.set_weight(new_user, 200)
    
    
    

    
    StructureManager.equalize_roles(new_user)
    
    assert division.get_weight(new_user) == 33
    assert division2.get_weight(new_user) == 67


def test_equalize_role_3div_not_empty(client, new_user):
    
    
    department1 = StructureManager.create_department(title="test_department")
    department2 = StructureManager.create_department(title="test_department2")
    division = StructureManager.create_division(title="test_division", department=department1)
    division2 = StructureManager.create_division(title="test_division2", department=department2)
    division3 = StructureManager.create_division(title="test_division3", department=department2)

    
    division.member_role.assign(new_user)
    division2.member_role.assign(new_user)
    division3.member_role.assign(new_user)
    
    division.set_weight(new_user, 100)
    division2.set_weight(new_user, 200)
    division3.set_weight(new_user, 300)
    
    
    StructureManager.equalize_roles(new_user)
    
    assert division.get_weight(new_user) == 17
    assert division2.get_weight(new_user) == 33
    assert division3.get_weight(new_user) == 50
    

    