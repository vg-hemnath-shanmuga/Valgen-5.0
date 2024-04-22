*** Settings ***
Documentation     This Button file has all button type locators of web application


*** Variables ***
# robocop: disable=section-variable-not-uppercase
${button.submit/reset}    id=btnreplaceText
${button.common.click}    //input[@name="btnreplaceText"]
${button.save}    //input[@value='Save']
${button.content.assign.document.initiate}    btnInitiateDevelop
${button.content.assign.authoring.additional_entity}    //label[@for='rbtnIncludeAdditionalEntitiesYes']
${button.content.assign.authoring.decision_tree}    //table[@id='rbtnEnableDestree']//label[text()='replaceText']
${button.module}    //div[@id="menuScrollDiv"]//a[text()="replaceText"]|//div[@class='left-menu-list']//span[text()="replaceText"]
${button.module.tab}    //li[contains(@class,"selected")]//div[@class="megamenu-tab-links"]//span[text()="replaceText"]
${button.module.tab.content}    //div[contains(@class,"content-holder")]//div[@style="display: block;"]//h5[text()="replaceText"]|//*[text()="replaceText1"]/parent::div/ul/li/a[text()="replaceText2"]
${button.success_alert.ok}    //input[@id='btnMessageOk']
${button.calendar.date.options}    //td[text()='replaceText1' and contains(@id,'replaceText2')]
${button.calendar.today_date}    //td[contains(text(),'Today: ') and contains(@id,'Today')]|//td[contains(@class,'Today') and contains(@id,'txtBoxTargetDate_DDD_C_m')]|//td[contains(@class,'Today') and contains(@id,'txtTargetDt_DDD_C_m')]|//td[contains(@class,'Today') and contains(@id,'datePickerForHoliday_DDD_C_m')]
${button.electronic_sign.submit/cancel}    id=val1_btnreplaceText
${button.test.electronic_sign.submit/cancel}    id=btnverify
${button.admin.search.activateuser}    //input[@id='btnADSSearch']
${button.boundTo}    //input/following-sibling::label[text()='replaceText']
${button.table.menu_tab}    //h5[text()='Table']
${button.search.project.assign.summary}    //input[@id='btnSearch']
${button.close.project.update.project}    //a[@id='lbClose']
${button.project.update.project.uploaddocument}    //label[text()='Upload Document']
${button.nextdefine.risk.create.risk framework}    //input[@name='btnvwVPOneNext']
${button.add.system.create.keywordmapping}    //input[@id='btnAddCol']
${button.decisiontree.assessmentbasedon}    //input/following-sibling::label[contains(text(),'replaceText')]
${button.notification_popup.ok}    id=btnMessageOk
${button.system.create.decision_tree.riskassess.section.save}    //input[contains(@id,'_btnSave')]
${button.notification_popup.home}    id=val1_LinkButton1
${button.content.document.left_menu}    //button[contains(@id,'replaceText')]
${button.content.assign.authoring.peer_review.addcomment}    //button[text()='Add Comment']
${button.common.btn_name}    //input[@value='replaceText']
${button.content.author.doc.decision_tree.complete}    //input[@value="Complete"]
${button.content.author.doc.decision_tree.previous/next}    //a//span[text()='replaceText']
${button.notification.ok/cancel}    //input[@id="replaceText"]
${button.edit/save_draft}    //input[@value='replaceText' and @id='btnSaveDraft']
${button.content.author.doc.appended_popup.ok}    //input[@id="btnConfirmOk"]
${button.home_page.title.tabs}    //ul[@class='nav nav-tabs mb_1']//li[@role='subtab']/a[contains(text(),'replaceText')]
${button.home_page.title.subtabs}    //div[@id='Tasktab']//li[@role='subtab']/a[contains(text(),'replaceText')]
${button.content.assign.authoring.peer_review.add_chat}    //button[@id='chat-msg-btn-add']
${button.content_library.tabs}    //div[@id='UltraWebTab1_header']//span[contains(text(),'replaceText')]
${button.content_library.saved.notification.ok}    (//input[@id="replaceText"])[2]
${button.content_generation.process_flow_diagram}    //input[@id="btnProcessFlowDiagram"]
${button.content.assign.document.add_approver}    //input[@id='vgw_btnAddApprovers']
${button.content.assign.document.delete}    //center//a[contains(@id,'Remove') and contains(@href,'true')]
${button.content.assign.document.approver.save}    //input[@id='vgw_btnESave']
${button.content.author.document.trace_matrix.uncovered_test_cases}    //a[@id='btnUnCover']
${button.content.author.document.trace_matrix.uncovered_test_cases.close}    //a[@id='lbClose']
${button.page_no}    //td//a[text()='replaceText']
${button.content.document.workflow.group_plus}    //input[@class='Group-plus']
${button.tab_title.document_id}    //span[@id='txtValDocNoTitle']
${button.verify_mapping}   (//a[text()='Verify Mapping'])[2]
${button.document.add_reply.reply_button}    //button[text()='Reply']
${button.document.add_attachments.upload}    //input[@value="Upload"]
${button.document.add_attachments.browse}    (//a[contains(text(),"Browse")])[2]
${button.document.edit}    //input[@value='Edit']
${button.alert_notification.mapping.ok}    //span[contains(text(),'replaceText')]/ancestor::div[contains(@class,'container-fluid popup')]//input
${button.assessment.create.framework.delivrable_option}    (//span[text()='replaceText1']//following::label[text()='replaceText2'])[1]
${button.inventory.entityname}    //input[contains(@value,'replaceText')]
${button.project.create.define.entity.save}    //span[text()='Save']
${button.project.create.define.next}    id=btnvwVPOneNext
${button.project.create.deliverables.next}    id=btnvwVPTwoNext
${button.project.create.phase.next}    id=btnvwVPThreeNext
${button.content.create.tracematrix.calendar}    //table[@id='txtTargetDt']
${button.system.create.bind_task.entity.save}    //input[starts-with(@id,"GridLookup") and @value="Save"]
${button.content.initiate.ccr.calendar}    //table[@id='txtBoxClosureDate']
${button.module_5.0}	//span[text()="replaceText"]//parent::a/i
${button.module.tab.content_5.0}	//li[contains(@class,"active")]//a[text()="replaceText"]
${button.document.sliderclose}    //a[@id='lbCloseTop']/following-sibling::input[@name='btnSliderClose']
${button.document.sliderclose.ValidationStandard}    //a[@id='lbCloseTop']|//i[@class='vg-icon-forward']/parent::a/parent::div/input
${button.contentlibrary.generate}    //input[@id='btn']
${button.decisiontree.option.selection}    //label[contains(text(),'replaceText')]/preceding-sibling::input
${button.content.initiate.ccr.additionaldeliverables.save}    //input[@name='btnSaveEnties']
${button.ccr.stakeholder.stakeholderassessment.sec1}    //table[@id='gvCurSH']//following::h4//span[@id='gvCurSH_ctl02_lnbsectionName']
${button.report.adhocreport.fields.formfields.save}    //input[contains(@id,'replaceText')]
${button.ccr.plan.implementaionpage.authoring.assign}    //table[@id='grvDevelopment']//following::input[contains(@name,'grvDevelopment') and @value='Assign']
${button.content.create.trace_matrix.save_docs.trace_matrix}    //a[@id="btnGenerateTrace"]
${button.report.view.audit_trail_report.search}	   //input[@id='ASPxSplitter1_btnSearch']
${button.content.author.deliverables.impactdeliveriables.table2}    //table[@id='FpReqExcel_cmdTable']//span//nobr[contains(text(),'Table 2')]
${button.ccr.plan.implementaionpage.authoring.contenttype.assign}    //table[@id='grvDevelopment']//following::span[text()='replaceText']//following::input[contains(@name,'grvDevelopment') and @value='Assign']
${button.common.name}    //input[@name='replaceText']
${button.content.author.content_library.import.browse}    //input[@class="uploadButton"]
${button.content.author.content_library.table.search.save}    //input[@id="btnSave"]
${button.content.author.content_library.import.upload.save}    //input[@id="btnShows"]
${button.content.save}    //input[@name='btnSave']
${button.univeral.submit.button.VLMS}    //input[@id="btnSubmit"]
${button.tree.VP}    //div[@id='trvEntity']//a[text()='Category_094402']/ancestor::tr//img
${button.subtree.VP}    //div[@id='trvEntity']//a[text()='SubCategory_094429']/parent::td/parent::tr/td[2]/a/img
${button.roleprofile.submit}    //input[@id="btnSave"]
${button_save}    //input[@id='btnEntitySave']
${buttonsave1}    //*[@id="btnSave"]
${button.accept}    //input[@id='btnAccept']
${button.create}    //*[@id="btnCreateValPlan"]
${button.department.create.submit}    //*[@id="btnSubmit"]
${button.submit.edit.roleprofile.access}    //input[@id='val1_btnSubmit']
${button.ok.reporting.manager.popup}     //input[@id="btnCommonAlertOk"]
${button.action.common}    //a[contains(@id,'LinkButton')]
${button.selectall}    //input[@id="ckObjectAll"]
${button.common.accept}    //input[@id='btnAccept']
${button.edit.view.role}    //a[@id='lnkViewEdit']
${button.submit.accessrole.settings}    //input[@id='val1_btnSubmit']
${button.search.task.common}    //span[@class='searchicon']
${button.system.create.decision_tree.section.answer.decision_required.pre}    //a[text()='Add' and not(contains(@style,"display:none"))]|//a[contains(@id,'_btnAddDeli') and not(contains(@style,"display:none"))]
${button.saveretire}                                                            //input[@id='btnSaveEntitiies']
${button.reviewsave}                                                            //input[@id='btnESave']
${button.Refresh}    //*[@id="Capa_1"]
${button.execution.execute.electronic_execution.status}	   //label[text()='replaceText']
${button.execution.execute.electronic_execution.record}	   //a[@id='WebSplitter1_btnRecord']
${button.execution.execute.electronic_execution.image}    //a[@id='WebSplitter1_btnimage']
${button.execution.execute.electronic_execution.test.excel_image}    //div[@id='divtools']//span[text()='Image']
${button.execution.execute.electronic_execution.test.pdf_image}    //a[@class='imagetool' and contains(@id,'A')]
${button.execution.execute.electronic_execution.test.pdf_file}    //a[@class='Filetool']
${button.execution.execute.electronic_execution.test.pdf_record}    //a[@id='btnrecorddata']
${button.execution.execute.electronic_execution.test.pdf_submit}    id=btneditsubmitdata
${button.execution.execute.electronic_execution.capture_screenshot}    id=btnScreenSnapshot
${button.execution.execute.electronic_execution.test_screensnap}    id=btnscreen_snap
${button.execution.execute.electronic_execution.textbox_properties.ok}    //button[text()='OK']
${button.execution.execute.electronic_execution.table.cell.bold}    (//i[@class='dx-icon dx-icon-bold'])[6]
${button.execution.execute.electronic_execution.image_capture}    id=CaptureOk
${button.execution.execute.electronic_execution.file}    //a[@id='WebSplitter1_btnfile']
${button.execution.assign.submit}    //input[@id='btnSubmit']
${button.home.dashboard.settings}    //button[@class='btn btn-default setting-btn']//img
${button.home.dashboard.chart.generate}    id=GenerateChart
${button.assessment.create.template.business_rule.save}    id=btnSaveBusiness
${button.assessment.create.template.validation_criteria.save}    //span[text()="Validation Criteria"]/ancestor::div//input[@id="btnSave"]
${button.assessment.create.template.business_rule_assessment.save}    id=btnAddBusinessRule
${button.assessment.perform_assessment.accept}    //input[contains(@id,"btnAcceptSection")]
${button.system.create.form.control_creation.settings.save}    //input[@id="btnClick"]
${button.system.create.form.control_creation.save}    id=btnSaveFields
${button.design.menu_tab}    //div[@id="UCTabEntityDetails_dvMenuList"]//span[text()[normalize-space()="replaceText"]]
${button.design.create_release_plan.resource.save}    id=btnSaveResGrp
${button.submit.esign.common}    //input[@id='val1_btnSubmit']|//input[@id='btnAdsSubmit']
${button.design.create_release_plan.feature_req.add}    id=btnFRselect
${button.design.risk_assessment.risk_id.risk_assessment.save}    id=Button1
${button.system.create.decision_tree.section.answer.add}    id=UltraWebTab1_grvSections_ctl02_btnAddAnswer
${button.system.create.decision_tree.section.answer.decision_required}    //a[text()='Add']
${button.content.document.assign}    //input[@id='btnAssign']
${button.system.create.decision_tree.section.action.content_library.add}    //input[@class='btnn btn-secondary add-btn' and @id='btnAdd']
${button.content.author.external_document.pdf.col_type.setting.save}    btnpropertysave
${button.content.author.external_document.pdf.page}    //button[text()='Page 3(1)']
${button.content.assign.document.add_reviewer}    id=vgw_btnAddReviewers
${button.vault.view.document.approved.search.parametric_section.save_search}    id=btnSaveSearch
${button.report.view.audit_trial_report.page_count}    //tr[@class='paginationno']//table//td
${button.report.view.audit_trial_report.page}    //a[text()='replaceText']
${button.report.view.audit_trial_report.page_double_right}    //i[@class='fa fa-angle-double-right']/ancestor::td/preceding-sibling::td/a[text()='...']
${button.vault.view.document.approved_doc_details.table.pdf.download.comment.submit}    //input[contains(@onclick,'Submitvalue')]
${button.initiate.content_library.new_task_type}    //label[contains(text(),'replaceText')]
${button.content.author.external_document.word.search.back}   //button[@result='back']
${button.content.author.external_document.word.search.replace}    //button[text()='Replace']
${button.risk.create.riskmodel.select_risk_factors.save_risk_factor}    id=btnFactorSave
${button.content.author.external_document.word.search.ok}    //button[@result='ok']
${button.save.system.spreadtemplate.associategroup}    //*[@id='btnSaveAddAssociateGroup']
${button.close.content.trace.tracematrix}    //div[contains(@id,'Header')]//input[@name='btnSliderClose']
