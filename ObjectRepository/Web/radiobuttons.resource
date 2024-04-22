*** Settings ***
Documentation     This radiobutton file has all radiobutton type locators of web application


*** Variables ***
# robocop: disable=section-variable-not-uppercase
${radiobutton.initiate_document.authoring_for}    //label[text()='replaceText']
${radiobutton.initiate_document.task_type}    //label[text()='replaceText']
${radiobutton.content.assign.authoring.assignment}    //label[text()='replaceText']
${radiobutton.common.id}    //input[contains(@id,'replaceText')]
${radiobutton.common.value}    //input[contains(@value,'replaceText')]
${radio.approveyes.project.assign.summary}    //label[@for='rbtnSummaryYes']
${radio.approveyes.project.approve.projectsummary}    //label[@for='rdoApprovalYES']
${radio.approveyes.content.approve.contentlibrary}    //label[@for='rdoApprovalYes']
${radio.bounddecisiontree.type.content.bind.decisiontree}    //input[@value='replaceText']
${radio.building.system.create.EntityType}    //label[@for='rbtBuildingReqNo']
${radiobutton.system.create.entity_type.version}    //span[contains(@id,'VerReq')]/parent::span/span/b
${radiobutton.project.create.deliverables.phase_name}    //input[@name='rbtnSettingsPhaseName']//ancestor::td//label[text()='replaceText']
${radiobutton.project.create.deliverables.phase_name_required}    id=lblPhaseName
${radiobutton.project.create.define.form_field.rb1}    //input[contains(@value,'13821')]
${radio.ApproveYes.Project.Approve.Project}    //input[@id='rdoApprovalYES']/following::label[text()='Yes']
${radio.documentcompleted.project.update.project}    //input[@id='rbtnYes']/following::label[@for='rbtnYes']
${radiobutton.system.create.decision_tree.section.action.decision_required.pre}    //span[contains(text(),"Is Decision Required")]//following::input[contains(@value,'replaceText')]/..//label
${radiobutton.system.create.form.control_creation.settings.translation_req}    //div[@id="pnlPopup"]//label[@for="replaceText"]
${radiobutton.design.requirements.canvas.reference.id}    //span[text()="replaceText"]/ancestor::td/preceding-sibling::td//input[@type="radio"]
${radiobutton.system.create.decision_tree.section.action.decision_required}    //input[contains(@value,'replaceText')]/..//label
${radiobutton.risk.riskmodel.additional_factors.field_type}    //label[contains(@for,"rbtnreplaceText")]
