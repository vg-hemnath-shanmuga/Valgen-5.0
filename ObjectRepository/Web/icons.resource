*** Settings ***
Documentation     This Icon file has all icon type locators of web application


*** Variables ***
# robocop: disable=section-variable-not-uppercase
${icon.home}    //span[contains(text(),"Home")]|//*[@class='vg-icon-home']
${icon.top_menu}    //span[contains(text(),'replaceText')]
${icon.home_5.0}    //span[text()="Home"]//parent::a/i
${icon.common.view}    //a[@id="btnView"]
${icon.common.view.details.navigation}    //div[@id="lbBottomNav"]//a[@title="replaceText"]
${icon.logout}    //span[text()="Logout"]//preceding-sibling::i
${icon.initiated.tasks.del}    //a[contains(@id,'InitRemove')]
${icon.content.section.search_icon}    //input[@id="btnSearch"]
${icon.inventory.tree_view.plus}    //a[(contains(@id,'Treeview')) and (contains(@href,'replaceText'))]
${icon.inventory.tree_view.minus}    //input[@value='replaceText']//ancestor::td//img[contains(@src,'minus')]
${icon.inventory.tree_view.minus}    //input[contains(@value,'replaceText')]//ancestor::td//*[@alt='Collapse']
${icon.content.assign_doc.calendar}    //table[@id='txtBoxTargetDate']
${icon.create_trace_model.calendar}    //table[@id="txtTargetDt"]
${icon.change.assess.ccr_owner.section.remove}    //span[text()="replaceText"]/ancestor::div[contains(@class,"mspace")]//th//a[contains(@onclick,"Remove")]
${icon.change.assess.ccr_owner.section.content_type.doc.remove}    //span[text()="replaceText1"]/ancestor::div[contains(@class,"mspace")]//span[text()="replaceText2"]/parent::td/parent::tr//a[contains(@id,"Remove") and not(contains(@style,"none"))]
${icon.change.assess.ccr_owner.calendar}    //table[@id="WebDateChooser2"]
${icon.content.author.content_library.create.table.add_row}    //img[@id="FpTestfnExcel_Add"]
${icon.content.author.content_library.table.reference.search_icon}    //td/input[@fpeditor="Button"]
${icon.mytasks.document.approvedocument.impacteddocument}    //td//a[@class='icon-image viewIconSep']
${icon.add}    //a[@id='btnAddControl']
${icon.add.sheet}    //a[@id='btnAddNewEntityRow']
${icon.content.author.content_library.create.table.delete_row}    //img[@id="FpTestfnExcel_Delete"]
${icon.content.author.content_library.create.table.insert_row}    //img[@id="FpTestfnExcel_Insert"]
${icon.create_tracematrix.doc_mapping.content_types}    //span[text()="replaceText1"]/ancestor::div[2]//tbody//span[text()="replaceText2"]/ancestor::tr//a/img[@alt="Expand "]
${icon.create_tracematrix.traceview.spreadview_tab.doc.expand}    //span[text()='replaceText']//preceding-sibling::a
${icon.assessment.assigned.validatedeliverables.contenttype.optional}    //span[text()='replaceText']//parent::div//span[contains(@id,'gvDevelopment')]//span[@class='fa fa-info-circle blue-info']
${icon.assessment.assigned.validatedeliverables.contenttype.mandatory}    //span[text()='replaceText']//parent::div//span[contains(@id,'gvDevelopment')]//span[@class='fa fa-info-circle red-info']
${icon.system.create.form.add_controls.control_creation.field.settings}    //div[@id="td_replaceText"]//a//i[@data-original-title="Settings"]
${icon.design.create_release_plan.estimated_start_date.calendar}    //table[@id="txtEstimatedStartDate"]
${icon.design.create_release_plan.estimated_target_date.calendar}    //table[@id="txtEstimatedEndDate"]
${icon.design.release_plan.manage_task}    //a[text()="replaceText"]/ancestor::td//following-sibling::td//a[contains(@id,"lnkReleaseView")]/img
${icon.design.screen.close}    //span[contains(text(),"replaceText")]/following-sibling::button//img[contains(@class,"close-icon")]
${icon.design.redirection_arrow}    //a//input[contains(@class,"backArrow")]
${icon.design.release_plan.manage_task.create_actual_task.calendar}    //table[@id="txtTaskStartDate"]
${icon.content.author.document.comments.delete}    //div[@class="edit-ct"]//div[contains(@class,"btn-delete")]
${icon.vault.view.document.approved.search.parametric_section.search}    id=btnPSearch
${icon.design.feature_request.backlog.search_icon}    //input[@id="txtSearch"]//following-sibling::input[@id="btnSearch"]
${icon.home.common}    //i[@class='vg-icon-system']