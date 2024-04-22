*** Settings ***
Documentation     This links file has all link type locators of web application


*** Variables ***
# robocop: disable=section-variable-not-uppercase
${link.content_library.select}    id=lnktestFn
${link.document.auto_mapping.fix/show}    //input[@id='gvMappingTable_ctl02_btnOpenCon' and @value='replaceText']
${link.document.attachments.add}    //span[text()="Attachments"]/parent::div/following-sibling::div//a[text()="Add"]
${link.system.create.entity.set_validation_rule}    //a[contains(@id,'btnValidationCriteria')]|//a[contains(@id,'lnkValidationFrame')]
${link.ccr.intitiate.entity.selecteddocument.select}    //a[@id='btnSelect']
${link.report.generate.adhocreport.fields}    //span[text()='replaceText']//parent::a//span
${link.content.author.impacteddeliverables.deliverables.processcondition}    //td[11]//a[@runat='server' and not (contains(text(),'N/A'))]
${link.content.selecteddeliverabletomaintain.completeddeliverable}    //span[@id='lblCompleatReq']//following::a[contains(text(),"replaceText")]
${link.content.author.content_library.select_task.create}    id=btnADD
${link.content.author.content_library.select_task.create.select_req}    id=btnSelect
${link.content.author.content_library.select_task.create.import}    id=btnImport
${link.content.author.content_library.import.browse.upload}    id=btnImportDoc
${link.execution.execute.electronic_execution.table_file_evidence}    //a[text()='[replaceText]']
${link.create_tracematrix.traceview.trace_dependencies.tracematrix_links}    //area[@shape="RECT" and contains(@onclick,"LNK")]
${link.create_tracematrix.traceview.trace_dependencies.tracematrix.specific_link}    //area[@shape="RECT" and contains(@onclick,"replaceText")]
${link.assessment.create.template.section_name.add}    //input[@id="btnAddSectionDet"]
${link.assessment.create.template.business_rule.gxp_impact.add}    //span[text()="GxP Impact"]/parent::td/following-sibling::td//input[@value="Add"]
${link.assessment.create.template.business_rule.gxp_noimpact.add}    //span[text()="GxP No Impact"]/parent::td/following-sibling::td//input[@value="Add"]
${link.assessment.create.template.business_rule_assessment.add}    id=btnAddBusinessRuleName
${link.assessment.perform_assessment.action}    //input[@value="Action" and contains(@class,"link")]
${link.assessment.perform.assessment.assigned.validatedeliverables.update}    //div[@id='divAddDeliverablebtn']//input[@name='btnUpdateDeliverables']
${link.assessment.create.assessment.section_name}    //div[@class='ajax__tab_header']//following-sibling::span//a[text()='replaceText']
${link.system.create.form.control_creation.settings.add}    //div[@class="settings-popup"]//span[text()="Add"]
${link.design.tablink}    //div[contains(@class,"tabLink")]//a[text()="replaceText"]
${link.design.feature_request.backlog.story_point}    //font[text()="replaceText"]/ancestor::td//following-sibling::td//a[contains(@id,"hypStoryPoint")]
${link.design.create_release_plan.deliverables.add}    id=lnkReqDelADD
${link.design.sprint.status.awaiting}    //a[text()="replaceText"]/ancestor::td/following-sibling::td//a[text()="Awaiting To Start" and contains(@id,"lblStatus")]
${link.design.value.task_id}    //span[contains(text(),"replaceText")]/parent::td/preceding-sibling::td//a
${link.design.task_id}    //a[text()="replaceText"]
${link.design.testcase.task_id}    //td[3]//span[contains(text(),"replaceText")]/parent::td/preceding-sibling::td//a
${link.design.testlab.task_id}    //td[2]//span[contains(text(),"replaceText1")]/parent::td/preceding-sibling::td//a[text()="replaceText2"]
${link.design.create_testcase.reference}    //a//span[@id="lblReference"]
${link.design.release_plan.manage_task.tab}    //a[contains(@class,"Link") and text()="replaceText"]
${link.design.select_all}    //a[text()="Select all"]
${linktext.select.task.common}    //*[text()="replaceText"]
${link.document.showdetails}    id=btnShowDetails
${link.content.assign.document.add_approver}    //a[@id='vgw_btnAddApprovers']
${link.design.release_plan.select_plan}    //span[contains(text(),"replaceText1")]/parent::td/preceding-sibling::td//a[text()="replaceText2"]
${link.system.create.decision_tree.section.add}    id=UltraWebTab1_btnAddSection
${linktext.phase.project.update.project}    //a[text()='Task']
${LinkText.system.System.Taxonomy}    //li[contains(@id,'tab')]//a[text()="replaceText"]
${linktext.selecttask.content.author.contentLibrary}    //a[@id='grdTestFnDev_ctl02_LnkbtnDocTemplatNo']
${link.system.create.decision_tree.riskassess.section.answer.add}    //div[contains(@id,'trAnswers')]/div/div/a
${linktext.project.assign.summary}    //a[@id='gvProjectSummaryReportsAssignment_ctl02_lnkgvProjectCode' or @id='grdviewDTAP_ctl02_lnkDTAPTaskId' or @id='gvProjectSummaryDevelopmentment_ctl02_lnkgvProjectCode' or @id='GrvInprogress_ctl02_lnkProjInprog' or @id='gvActiveSummaryPeerReviewers_ctl02_lnkActiveVpcodePR' or @id='gvReviewValidationActive_ctl02_lnkActiveVpcode' or @id='GrvRcomplete_ctl02_lnkProjRCode' or @id='gvProjectSummaryPeerReviewComplete_ctl02_lnkgvProjectCode' or @id='gvProjectSummaryReviewComplete_ctl02_lnkgvProjectCode' or @id='gvReview_ctl02_lnkItemTemplateNo' or @id='grdDevRev_ctl02_LnkbtnDocTemplatNo' or @id='gvApproval_ctl02_lnkTemplateNo' or @id='grvDesignReview_ctl02_lnkTitle' or @id='grvRevComp_ctl02_lnkTitle' or @id='grvApproveDesign_ctl02_lnkTitle' or @id='grvReviewRTM_ctl02_lnkTitle' or @id='grvApproveRTM_ctl02_lnkTitle' or @id='gvReviewRiskFrameWork_ctl02_lnkRiskFrameWorkName' or @id='gvReviewCompletedRiskFrameWork_ctl02_lnkRiskFrameWorkName' or @id='gvApproveRiskFrameWork_ctl02_lnkRiskFrameWorkTitle']
${link.system.create.decision_tree.section.answer.add}    id=UltraWebTab1_grvSections_ctl02_btnAddAnswer
${link.system.create.decision_tree.section.answer.decision_required}    //a[text()='Add']
${link.execution.execute.electronic_execution.table.image}    //td//a[text()='replaceText']
${link.home.content_flow.execution_id}    //div[@id='ContentflowDiagram']//*[name()='svg']//*[name()='text' and contains(text(),'replaceText')]
${link.execution.execute.electronic_execution.table.cell.image}    //a[contains(text(),'replaceText')]
${link.vault.view.document.approved_doc_details.view}    //font[text()="replaceText"]/ancestor::tr//td/a
${link.content.author.external_document.check_in}    //input[@value='Check In']
${link.content.author.external_document.check_out}    //a[text()='Check Out']
${link.risk.create.riskmodel.derivative_factor.add}    //input[@id="btnAddFormula"]
${link.risk.create.riskmodel.derivative_factor.factor_name.add}    //span[contains(@id,"RowNo") and text()="replaceText"]/ancestor::td//input[@value="Add"]
${link.risk.create.riskmodel.business_rule.operator.add}    //span[contains(@id,"lblName") and text()="replaceText"]/ancestor::tr//input[contains(@id,"lnkRevAddDtl")]
${link.risk.create.riskmodel.business_rule.process_cond.add}    //span[contains(@id,"lblName") and text()="replaceText"]/ancestor::tr//td[@class="width-5"]//input[contains(@id,"lnkRevAdd")]
${link.contentlibrarytask.content.contentlibrary}    //a[@id='grdTestFnDev_ctl02_lnkDocTemplatNo']
