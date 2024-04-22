*** Settings ***
Documentation     This Checkboxes file has all checkbox type locators of web application


*** Variables ***
# robocop: disable=section-variable-not-uppercase
${checkbox.content.assign.authoring.peer_review_completed}    //input[@id='chkReviewed']
${checkbox.content.author.doc.confirm_routing}    //input[@id="chkConfirm"]
${checkbox.content_library.select}    //span[contains(@id,'SelBtn')]
${checkbox.content.assign.document.approver}    //span[text()='replaceText']/parent::td/input
${checkbox.content.author.doc.initiated.tasks}    (//input[contains(@id,'InitRemove')])[1]
${checkbox.document.auto_mapping.include}    //input[contains(@onclick,'CheckAll')]
${checkbox.content.edit_doc.group_header}    //tr[@class="tr-header"]//input[@type="checkbox"]
${checkbox.content.edit_doc.group.user}    //span[contains(text(),'replaceText')]/parent::td/input
${checkbox.create_tracemodel.image.checkbox}    //input[@runat="server" and not(@disabled)]
${checkbox.create_tracemodel.image.enabled_checkboxes}    (//input[@runat="server" and not(@disabled)])[replaceText]
${checkbox.system.create.entity.set_validation_rule.deliverables}    //label[text()='replaceText']//parent::td//input
${checkbox.system.create.entity.set_validation_rule.deliverables.save}    //input[contains(@onclick,'ValidateCriteria')]
${checkbox.project.create.define.entity}    //td[text()='replaceText']
${checkbox.project.create.define.form_details.cb1}    //input[contains(@id,'chkListLeft')]//ancestor::li//label[text()='Option1']
${checkbox.project.create.define.form_details.checkbox}    //input[contains(@id,'chkListLeft')]//ancestor::li//label[text()='replaceText']
${checkbox.project.create.deliverables.additional_deliverables}    //a[text()='replaceText1']/ancestor::table/following-sibling::div[1]//a[text()="replaceText2"]//preceding-sibling::input
${checkbox.content.create.tracematrix.documentmapping}    //input[@id='chkSelectAllDoc']
${checkbox.content.create.tracematrix.document_unmapping}    //span[contains(text(),'replaceText')]//parent::span//preceding-sibling::input
${checkbox.system.create.bind_task.entity}    //td[contains(text(),'replaceText')]/parent::tr//span[contains(@class,"CheckBox")]
${checkbox.change.initiate.entity.selectdocument.selectall}    //table[@id='FpExcel_top_table']//tbody//following::div//input[@id='FpExcel_0,0,ch']
${checkbox.select}    //input[contains(@id,'replaceText')]
${checkbox.report.adhocreport.fields}    (//input[@value='replaceText']//parent::td//following::td//span//input)[1]
${checkbox.report.adhocreport.fields.selectall}    //td[contains(@id,'replaceText1')]//span[contains(@id,'replaceText2')]//span//input
${checkbox.report.create.ad_hoc_report.status}    //label[text()='replaceText']//ancestor::td//input
${checkbox.report.create.ad_hoc_report.status.all}    //label[text()='All']//ancestor::td//input
${checkbox.change.assess.ccr_owner.content_type.docs_checkboxes}    //span[text()="replaceText1"]/ancestor::div[contains(@class,"mspace")]//span[text()="replaceText2"]/parent::td/parent::tr//input[@type="checkbox"]
${checkbox.change.initiate.select.frs_document.enable}    //input[contains(@id,'FpExcel') and not (contains(@disabled,'disabled'))]
${checkbox.change.initiate.select.frs.checkbox_status}    //td[text()='replaceText']//preceding::td[@locked='true']//div[@fpeditor='CheckBox']//span//input[@disabled='disabled']
${checkbox.change.initiate.select.frs.checkbox}    //td[text()='replaceText']//parent::tr//td//input[@type='checkbox']
${checkbox.content.create.trace_matrix.selected_req_docs}    //span[text()="Requirement Documents"]/ancestor::div[2]//input[@checked="checked"]/following-sibling::span/span
${checkbox.content.create.trace_matrix.selected_exe_docs}    //span[text()="Executable/Content Library Documents"]/ancestor::div[2]//input[@checked="checked"]/following-sibling::span/span
${checkbox.content.author.impacteddeliverables.deliverables.processcondition}    //span[text()='replaceText']//parent::td//preceding-sibling::td//input
${checkbox.create_tracemodel.map.content_library_type}    //input[contains(@id,"replaceText") and not(@disabled)]
${checkbox.create_tracemodel.map.content_types}    //input[contains(@id,"replaceText1") or contains(@id,"replaceText2") and not(@disabled)]
${checkbox.content.author.content_library.select_req.select_checkboxes}    //div[@fpeditor="CheckBox"]/input
${checkbox.content.author.content_library.table.reference.select_requirements}    //span[text()='replaceText']/parent::td/parent::tr//input[@type="checkbox"]
${checkbox.content.author.content_library.select_content_libno.checkbox}    //a[text()="replaceText"]/parent::td/parent::tr//td[1]//input[@type="checkbox"]
${checkbox.content.author.content_library.select_req.select_req_no}    //td[text()='replaceText']/parent::tr//input[@type="checkbox"]
${checkbox.create_tracematrix.tracemodel.selected_checkboxes}    //input[@id="replaceText" and @checked]
${checkbox.create_tracematrix.create.trace_matrix.traceview_mappedcheckboxes}    //span[@id="replaceText1"]/parent::td//following-sibling::td[replaceText2]/input[@class="InputStyle RTM_Tick"]
${checkbox.site.selection.Access.control}    //input[@id="chkAll"]
${checkbox.tree.vp}    //div[@id='trvEntity']//a[text()='New Entity2(ED34)']/parent::td/input
${checkbox.routing.VP}    //*[@id="chkConfirm"]
${checkbox.selectallusers.crosssiteprofile}    //span[text()="replaceText"]/parent::td/following::td/input
${checkbox.templatetype.risk.create.riskframework}    //span[text()='replaceText']/parent::td/parent::tr/child::td//input
${checkbox.decisiontree.content.bind.decisiontree}    //a[contains(text(),'replaceText')]/preceding-sibling::input
${checkbox.bind.template.workflow.applicableto}    //span[@id='lBoxWorkflow_LBSACB_S_D']
${checkbox.reviewcomplete.project.review.project}    //input[@id='chkReviewed']
${checkbox.category.content.bind.decisiontree}    //a[text()='replaceText']/preceding-sibling::input
${checkbox.bind.template.contenttype}    //span[@id='lBoxValType_LBSACB_S_D']
${checkbox.selectalluser.groups}    //div[@class="dxeListBoxSelectAll"]//span[contains(@id,"lboxAvilableUser")]
${checkbox.selectall.WF}                                                                        //input[contains(@id,'chkAll')]
${checkbox.roleprofile.noaccess}    //input[@title="replaceText"][contains(@id,'Check1')]
${checkbox.availableuser.groups}    //tr[@class="dxeListBoxItemRow"]//span[contains(@id,"lboxAvilableUser")]
${checkbox.roleprofile.viewaccess}    //input[@title="replaceText"][contains(@id,'Check2')]
${checkbox.roleprofile.fullaccess}    //input[@title="replaceText"][contains(@id,'Check3')]
${checkbox.content.assign.authoring.peer_review_completed}    //input[@id='chkReviewed']
${checkbox.execution.execute.electronic_execution.file.initiate_deviation.document}    //a[text()='replaceText']//ancestor::td//input
${checkbox.execution.execute.electronic_execution.file.initiate_deviation.insert_document}    //span[contains(text(),'replaceText')]//ancestor::tr//input[(contains(@id,'chkattach')) and (@type='checkbox')]
${checkbox.execution.execute.electronic_execution.confirm_routing}    //input[@id="chkconfirm"]
${checkbox.execution.execute.electronic_execution.textbox_properties}    //label//span[text()='replaceText']
${checkbox.content.create.trace_matrix.selected_documents}    //input[@checked="checked"]/following-sibling::span/span
${checkbox.assessment.create.template.validation_icon.popup.select_framework}    //label[text()="replaceText"]/preceding-sibling::input
${checkbox.system.create.form.form_applicable.select_all}    //input[@id="chkAll"]
${checkbox.admin.Activate.User}    //*[text()='replaceText']/parent::span/parent::td/preceding-sibling::td//input[contains(@id,'chkselect')]
${checkbox.system.create.form.form_applicable_to.type}    //label[text()="replaceText"]/preceding-sibling::input[@type="checkbox"]
${checkbox.design.select_all}    //input[contains(@id,"chkSelectAll")]
${checkbox.reporting.manager.click}    //input[@id="chkReportingManager"]
${checkbox.design.feature_request.accept.feature_req_id.checkbox}    //a[text()="replaceText"]/parent::td/preceding-sibling::td//input[@type="checkbox"]
${checkbox.design.feature_request.backlog.story_point_assessment.story_point}    //span[text()="replaceText1"]/ancestor::tr[1]/following-sibling::tr//span[normalize-space()="replaceText2"]//input
${checkbox.design.create_release_plan.feature_req_id.checkbox}    //span[text()="replaceText"]/ancestor::td/preceding-sibling::td//input[@type="checkbox"]
${checkbox.design.testcase.route_for_approval.select_tc.tc_name}    //label[text()="replaceText"]//input
${checkbox.design.release_plan.manage_release.checkbox}    //input[@id="chkReleaseCompleted"]
${checkbox.system.create.decision_tree.section.action.content_library}    //a[text()='replaceText']//ancestor::td//span[contains(@id,'DXSelBtn')]
${checkbox.content.author.external_document.pdf.col_type.setting}    //input[@id='replaceText']
${checkbox.vault.view.document.approved.search.parametric_search.all}    //table[@id="chkFilter"]//b[text()="All"]/parent::label//preceding-sibling::input
${checkbox.vault.view.document.approved.search.parametric_search.parameter_checkbox}    //table[@id="chkFilter"]//label[text()="replaceText"]//preceding-sibling::input
${checkbox.Activateuser.Administartion.User}    //font[text()="replaceText"]/parent::span/parent::div/parent::td/preceding-sibling::td/center/input[@type='checkbox']
${checkbox.Select.system.bind.decisiontree}    //td[text()="replaceText"]/preceding-sibling::td/span[contains(@class,'dxICheckBox')]
