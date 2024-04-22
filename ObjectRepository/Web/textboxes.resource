*** Settings ***
Documentation     This Textbox file has all textbox type locators of web application


*** Variables ***
# robocop: disable=section-variable-not-uppercase
${textbox.common.select.value}    //div[@id='dvDefaultRule']/div//input
${textbox.login.username}    //input[@id="txtUserName"]
${textbox.login.password}    //input[@id="txtPassword"]
${textbox.common.comments/desc}    id=replaceText
${textbox.content.assign.authoring.document_title}    //textarea[@name='txtBoxDocumentTitle']
${textbox.content.assign.authoring.document_desc}    //textarea[@name='txtBoxDescription']
${textbox.content.assign.authoring.additional_entity}    //input[@id='GridLookup_DDD_gv_DXFREditorcol1_I']
${textbox.electronic_sign.user}    //input[@id='val1_txtUser']
${textbox.test.electronic_sign.user}    //input[@id='txtUser']
${textbox.electronic_sign.password}    id=val1_txtPassword
${textbox.test.electronic_sign.password}    //input[@id='txtPassword']
${textbox.content.assign.authoring.peer_review.comment}    id=comment-msg-new
${textbox.content.author.doc.decision_tree.justification}    //textarea[@name="valAction$txtJustification"]
${textbox.home.search}    //input[@type='search' and contains(@st-search,'Description')]
${textbox.content.author.doc.route.search_user}    //input[@id='lboxRouteToFilter_I']
${textbox.content.author.doc.route.peer_tenure}    //input[@id="txtPeerTenure"]
${textbox.common.mandatory.text_field}    id=txtreplaceText
${textbox.content.assign.authoring.peer_review.chat}    //div[@id='chat-options-ct']//textarea
${textbox.lbframe_screen.filter_box}    //input[contains(@id,'EditorcolreplaceText_I')]|(//input[contains(@id,'EditorcolreplaceText1_I')])[replaceText2]
${textbox.content.assign.document.approver.approval_period}    //input[contains(@id,'vgw_grvApprove_ctl03_txtTenure')]
${textbox.content.assign.document.approver.alert_frequency}    //input[contains(@id,'grvApprove_ctl03_txtAlertAfterEvery')]
${textbox.view_icon.view_details.filter_box}    //input[contains(@id,'EditorcolreplaceText_I')]
${textbox.view_icon.view_details.filter_box.value}    //input[@value='replaceText']
${textbox.document.add_reply}    //textarea[@placeholder="Add Reply"]
${textbox.system.create.entity_type}    //input[@id='txtEntityTypeName']
${textbox.system.create.entity.prefix}    //input[@id='txtPrefix']
${textbox.system.create.entity.search}    //select[contains(@id,"Frameworks")]/following-sibling::span//input[@type="search"]|//input[@type='search']
${textbox.assessment.framework.description}    //body[contains(@class,'dxheDesignViewArea')]
${textbox.project.create.project_name}    id=txtVPtitle
${textbox.project.create.define.form_field.ta1}    //body[contains(@class,'dxheDesignViewArea')]
${textbox.project.create.define.form_field.tb1}    //textarea[contains(@id,'EntFields')]
${textbox.project.create.project_id}    id=txtProjcode
${textbox.project.create.schedule.duration_in_days}    //span[text()='replaceText1']//ancestor::tr//td//span[text()='replaceText2']//ancestor::tr//td//input[contains(@id,'txtDuration')]
${textbox.project.create.deliverables.phase}    id=gvPhaseName_ctl0replaceText_txtGrdPhaseName
${textbox.system.create.bind_task.entity.search}     (//table[starts-with(@id,"replaceText")]//input[contains(@class,"dxeEditArea")])[last()]
${textbox.report.create.ad_hoc_report.title}	   id=txtReportTitle
${textbox.report.view.audit_trail_report.search}	//input[@id='ASPxSplitter1_txtSearch']
${textbox.content.author.impacteddeliverables.deliverables}    //td//input[@class="DefaultInput"]
${textbox.content.author.impacteddeliverables.deliverables.fields}    //tr[@fpkey="replaceText"]//td
${textbox.attachments.browse.input}    //input[contains(@id,"Control_TextBox0_Input")]
${textbox.checkout.attachments.browse.input}    //input[contains(@id,"ControlOffline_TextBox0_Input")]
${textbox.content.author.content_library.import.fileupload}    //input[@id="filExcel"]
${textbox.category.name.field}    //input[@id="txtCatName"]
${textbox.category.prefix.field}    //input[@id="txtPrefix"]
${textbox.category.description.field}    //textarea[@id="txtDescription"]
${textbox.rolename.field}    //input[@id="txtboxRoleName"]
${textbox.Role.Description.field}    //textarea[@id="txtBoxDesc"]
${textbox.approve.text}                                                                 //input[@id="grvApprove_ctl02_txtTenure"]
${textbox.approve.FRole}                                                                //input[@id="grvApprove_ctl02_txtAlert"]
${textbox.review.text}                                                                  //input[@id='grvReview_ctl02_txtTenure']
${textbox.review.FRole}                                                                 //input[@id='grvReview_ctl02_txtAlert']
${textbox.admin.access control.comments}    //textarea[@id="val1_txtActionComments"]|//textarea[@id="txtComments"]
${textbox.execution.execute.electronic_execution.row}    //input[@id='WebSplitter1_txtRow']
${textbox.execution.execute.electronic_execution.actual_result}    //p[contains(@style,'margin')]
${textbox.execution.execute.electronic_execution.actual_result1}    //link[@rel='stylesheet']//ancestor::html
${textbox.execution.execute.electronic_execution.table.cell}    //input[contains(@class,'e-pv-formfield-input')]
${textbox.execution.execute.electronic_execution.table.cell.name}    //input[@id='input_Name']
${textbox.execution.execute.electronic_execution.table.cell.tooltip}    //input[contains(@class,'tooltip-prop-input')]
${textbox.execution.execute.electronic_execution.table.cell.value}    //input[contains(@class,'properties-value-input')]
${textbox.execution.execute.electronic_execution.pdf.table.cell}    //textarea[@name='TAreplaceText']
${textbox.execution.execute.electronic_execution.pdf.actual_result}    //div[@class='ql-editor ql-blank dx-htmleditor-content']
${textbox.execution.execute.electronic_execution.pdf.reason_for_edit}    //div[@class='dx-quill-container ql-container']
${textbox.execution.execute.electronic_execution.pdf.choose_file}    //input[@id='File1_TextBox0_Input']
${textbox.execution.execute.electronic_execution.pdf.attachment_name}    //td[text()='replaceText']
${textbox.execution.execute.electronic_execution.pdf.edit_actual_result}    //div[@class='ql-editor dx-htmleditor-content']
${textbox.execution.execute.electronic_execution.execution_template_textarea}    //body[contains(@class,'dxheDesignViewArea')]
${textbox.execution.execute.electronic_execution.re_execution_rows}    //input[@id='gvReExecuteRows_ctl02_txtRows']
${textbox.execution.execute.electronic_execution.approval.comment}    id=txtComments
${textbox.assessment.create.template.template_name}    //input[@id="txTempName"]
${textbox.assessment.create.template.gxp_section.description}    //textarea[contains(@id,"grdSections_ctl02_FrmFields")]
${textbox.assessment.create.template.business_rule_assessment.va_assessment_result}    //select[contains(@id,"ddlValidation")]/following-sibling::span//input[@type="search"]
${textbox.assessment.create.template.validation_icon.popup.select_frameworks}    //input[contains(@id,"txtFrameworks")]
${textbox.assessment.performassessment.update.justification}    //textarea[contains(@id,'replaceText')]
${textbox.system.create.form.form_type}    id=ddlCFormtype_I
${textbox.common.Enter}    //input[@name="txtreplaceText"]
${textbox.username.esign.common}    //input[@id='val1_txtUser']
${textbox.password.esign.common}    //input[@id='val1_txtPassword']
${textbox.comments.cross.site.profile}    //textarea[@id='txtComments']
${textarea.description.system.create.functionalrole}    //textarea[@name="txtFnRoleDesc"]
${textbox.search.task.common}    //input[@id='topSearch']
${textarea.comments.edit.roleprofile.access}    //textarea[@name="val1$txtActionComments"]
${textbox.search.reason.esign.common}    (//input[@class='chosen-search-input'])[1]
${textbox.search.system.create.form.applicableTo}    //div[contains(@id,'chkApplicableTo_')]//input
${textbox.system.create.form.add_controls.control_creation.form_field_details.cell}    //div[@id="td_replaceText"]
${textbox.system.create.form.control_creation.settings.helptext}    //body[contains(@class,"dxheDesignViewArea")]
${textbox.risk.assess.risk_assessment.risk_required}    //textarea[@id="EntFields_gvMain_ctl02_gvIni_ctl02_txtFiled"]
${textbox.risk.assess.risk_assessment.risk_framework_required}    //textarea[@id="EntFields_gvMain_ctl02_gvIni_ctl03_txtFiled"]
${textbox.risk.create.riskmodel.factorlevelname}    //input[@id='replaceText']
${textbox.risk.create.riskmodel.severity.levelname}    //span[contains(@id,"lblSection") and text()="replaceText1"]/ancestor::tr//input[contains(@id,'replaceText2')]|//input[starts-with(@id,'replaceText1') and contains(@id,'replaceText2')]
${textbox.design.feature_request.action.create.user_story}    id=grdProductBackLogUserStory_ctl03_txtTitle
${textbox.design.release_plan.create_task.estimated_hours}    id=DurationTxt
${textbox.design.frame.description}    //body[@class="dxheDesignViewArea dxheViewArea dxhe-docTypeXHTML"]
${textbox.design.risk_assessment.justification}    //textarea[@id="gvLoadScale_ctl02_txtComments"]
${textbox.system.create.decision_tree.section}    UltraWebTab1_txtSection
${textbox.system.create.decision_tree}    txtDecisionTreeName
${textbox.system.create.decision_tree.answer}    UltraWebTab1_grvSections_ctl02_grvAnswers_ctl0replaceText_txtAnswer
${textbox.system.create.decision_tree.section.question}    //textarea[@id='UltraWebTab1_grvSections_ctl02_txtQuestions']
${textbox.system.create.decision_tree.section.question_prefix}    //input[@id='UltraWebTab1_grvSections_ctl02_txtQnPrefix']
${textbox.config.create.sitename}    //input[@id='txtSiteName']
${textbox.config.create.siteprefix}    //input[@id='txtPrefix']
${textbox.group}    //input[@id="lboxAvilableUserFilter_I"]
${textbox.project.assign.summary}    //input[@id='txtSearch']
${textbox.project.assign.summary.summarytitle}    //textarea[@id='txtSummaryTitle']
${textbox.columnheader.create.risk.framework}    //input[@id='gvSelectedColumn_ctl05_txtColumnHeader']
${textbox.columnheader.system.craete.keywordmapping}    (//input[contains(@id,'txtColHeader')])
${textbox.header.mandatory.text_field}    //input[@name='replaceText']
${textbox.bindto.search}    //input[contains(@id,'GridLookup_DDD_gv_DXFREditorco')]
${textbox.system.create.decision_tree.riskassess.section.question_prefix}    //input[@id='UltraWebTab1_grvSections_ctl0replaceText_txtQnPrefix']
${textbox.system.create.decision_tree.riskassess.section.question}    //textarea[@id='UltraWebTab1_grvSections_ctl0replaceText_txtQuestions']
${textbox.system.create.decision_tree.riskassess.answer}    UltraWebTab1_grvSections_ctl0replaceText2_grvAnswers_ctl0replaceText1_txtAnswer
${textbox.template.tobind.search}    //input[contains(@id,'gvLookupTemp_DDD_gv_DXFREditorcol2_I')]
${textbox.system.create.decision_tree.section.action.content_library}    //span[text()='Content Library No.']//ancestor::td//tr//following-sibling::tr[1]//tbody//input[contains(@id,'GenericSearch_DXFREditorcol1')]
${textbox.content.author.external_document.mapping.row_start}    txtStartRowStartCol
${textbox.content.author.external_document.mapping.row_end}    txtStartRowEndCol
${textbox.content.author.external_document.mapping.col_start}    txtEndColStartRange
${textbox.content.author.external_document.mapping.col_end}    txtEndColEndRange
${textbox.content.author.external_document.word.table.rows}    //label[text()='Number of Rows']/..//input
${textbox.content.author.external_document.word.table.cols}    //label[text()='Number of Columns']/..//input
${textbox.execution.execute.electronic_execution.file.attachment_name}    //textarea[@id='txtattach']
${textbox.content.assign.document.reviewer.review_period}    //input[contains(@id,"vgw_grvReview_ctl04_txtTenure")]
${textbox.content.assign.document.reviewer.alert_frequency}    //input[contains(@id,"grvReview_ctl04_txtBoxAlert")]
${textbox.design.feature_request.search_box}    //input[@id="txtSearch"]
${textbox.content.author.external_document.word.search}    sd-text-search
${textbox.content.author.external_document.word.replace}    sd-text-replace
${textbox.risk.create.riskmodel.select_risk_factors.factorlevel_name}    //div[@id="trFactorLevel"]//input[contains(@id,"txtName")]
${textbox.risk.create.riskmodel.select_risk_factors.factorlevel_description}    //div[@id="trFactorLevel"]//input[contains(@id,"txtDescription")]
${textbox.risk.create.riskmodel.derivative_factor.factor_name}    //input[@id="txtResultFactor"]
${textbox.risk.create.riskmodel.business_rule.score_from}    //span[contains(@id,"lblName") and text()="replaceText"]/ancestor::tr//input[contains(@id,"txtFrom")]
${textbox.risk.create.riskmodel.business_rule.score_to}    //span[contains(@id,"lblName") and text()="replaceText"]/ancestor::tr//input[contains(@id,"txtTo")]
${textbox.risk.create.riskmodel.select_additional_factors.factorlevel_name}    //div[@id="trCustomFactorLevel"]//input[contains(@id,"txtName")]
${textbox.risk.create.riskmodel.select_additional_factors.description}    //div[@id="trCustomFactorLevel"]//input[contains(@id,"txtDescription")]
${textbox.search.system.bind.decisiontree}    //input[contains(@id,'DXFREditorcol1_I')]
${textbox.system.create.DMuniqueID.ConetntIDName}    //input[@id="txtreqname"]
${textbox.system.create.DMuniqueID.submit}    //input[@id="UltraWebTab1_pnltabReq_btnreqSubmit"]
${textbox.system.create.calendar.starttime}    //input[@id='txtDefaultStartTime_I']
${textbox.system.create.calendar.endtime}    //input[@id='txtDefaultEndTime_I']
${textbox.system.create.calendar.calendarname}    //input[@id='txtCalendarName']
${textarea.title.content.tracematrix}    //textarea[@id='txtTitle']



