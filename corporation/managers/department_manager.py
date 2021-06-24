from flask import render_template, url_for, flash, redirect, request, Blueprint
from flask_login import current_user, login_required
from corporation import db, discord
from corporation.models import Post, User, Role, Division, Department, Rolevsuser, Webpage_template
from flask_discord import requires_authorization
from corporation.managers.forms import Department_Form, Division_Form, Role_Form, Search_Form, Dep_Form, Div_Form, Role_edit_Form, Role_edit_color_Form, Department_webpage_form
from corporation.managers.utils import save_background, save_logo
from corporation.managers import managers


@managers.route("/department_manager/add_template/<int:department_id>", methods=['GET', 'POST'])
@login_required
def department_new_template(department_id):
    if not current_user.is_manager('admin'):
        return redirect(url_for('main.home'))
    
    template = Webpage_template(department_id = department_id )
    db.session.add(template)
    db.session.commit()
    return redirect(url_for('managers.department_manager'))


@managers.route("/department_manager", methods=['GET', 'POST'])
@login_required
def department_manager():
    if not current_user.is_manager('admin'):
        return redirect(url_for('main.home'))
    
    
    form = Department_Form(prefix="new")
    if form.submit.data and form.validate_on_submit():
        
        department = Department(title= form.title.data, created_by= current_user.RSI_handle)
        db.session.add(department)
        db.session.commit()
        
        department_id = department.id
        dp_head = Role(title= form.title.data + " Head", dep_head = True , created_by = current_user.RSI_handle , department_id = department_id )
        dp_proxy = Role(title= form.title.data + " Proxy", dep_proxy = True, created_by = current_user.RSI_handle , department_id = department_id )
        db.session.add(dp_head)
        db.session.add(dp_proxy)
        db.session.commit()
        flash('The Department has been created!', 'success')
        return redirect(url_for('managers.department_manager'))
    
    update_form = Dep_Form(prefix="update")
    if update_form.update.data and update_form.validate_on_submit():
        department = Department.query.filter_by(id = update_form.department_id.data).first()
        department.title = update_form.title.data
        department.color = update_form.color.data
        
        head = Role.query.filter_by(department_id = department.id, dep_head= True).first()
        proxy = Role.query.filter_by(department_id = department.id, dep_proxy= True).first()
        
        head.title = department.title +" Head"
        proxy.title = department.title +" Proxy"
        
        db.session.commit()
        flash('The Department has been updated!', 'success')
        return redirect(url_for('managers.department_manager'))
    
    dep_form = Department_webpage_form(prefix="update_dep")
    if dep_form.update_dep.data and dep_form.validate_on_submit():
        department_item = Department.query.filter_by(id = dep_form.department_id.data).first()
        
        for image in dep_form.header_images:
            print(image.background_image.data)
            if image.background_image.data :
                if image.image_id.data == "1":
                    department_item.image_file_1 = save_background(image.background_image.data)
                elif image.image_id.data == "2":
                    department_item.image_file_2 = save_background(image.background_image.data)
                elif image.image_id.data == "3":
                    department_item.image_file_3 = save_background(image.background_image.data)
                elif image.image_id.data == "4":
                    department_item.image_file_4 = save_background(image.background_image.data)
            
        if dep_form.div_background.data :
            department_item.image_div_presentation = save_background(dep_form.div_background.data )
        
        for tempate_details in dep_form.detail_sections:
            template = Webpage_template.query.filter_by(id = tempate_details.template_id.data).first()
            template.title = tempate_details.title1.data
            template.title2 = tempate_details.title2.data
            template.text = tempate_details.text.data
            if tempate_details.background_image.data :
                template.background_image = save_background(tempate_details.background_image.data)
                
        db.session.commit()
        flash('The Department has been updated!', 'success')
        return redirect(url_for('managers.department_manager'))
        
    
    return render_template("managers/department_manager.html", title = "Department manager", Role = Role,  form=form, update_form=update_form, dep_form=dep_form)
