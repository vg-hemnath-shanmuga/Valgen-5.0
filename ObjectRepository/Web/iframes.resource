*** Settings ***
Documentation     This Frame file has all frame type locators of web application


*** Variables ***
# robocop: disable=section-variable-not-uppercase
${iframe.framecontent}    //iframe[@id="framecontent"]
${iframe.content.document_frame}    //iframe[@id="iframDoc"]
${iframe.content.document.frame_editor}    //iframe[@name="frameEditor"]
${iframe.library_frame.screen}    //iframe[@id='iframeFrameWorkLink']|//iframe[@id='lbIframe']
${iframe.fix.table_header&type}    id=ifrmeDetails
${iframe.view_icon.view_details.frame}    //iframe[@id="lbIframe"]
${iframe.home.inventory_details}    //iframe[@id='WebSplitter1_InventoryDetails']
${iframe.assessment.create.framework}    //iframe[@id='EntFields_gvMain_ctl02_gvIni_ctl02_txtLTA_DesignIFrame']
${iframe.project.create.project_desc}    //iframe[@id='txtProjDesc_DesignIFrame']
${iframe.project.create.define.form_field}    //iframe[contains(@id,'EntFields_gvMain')]
${iframe.content.template.description}    //iframe[@id="txtBoxDesc_DesignIFrame"]
${iframe.project.update.project}    //iframe[@id='lbIframe']
${iframe.execution.execute.electronic_execution}    //iframe[@id='iframToolBar']
${iframe.execution.execute.electronic_execution.actual_result}    //iframe[@id='WebSplitter1_tcExecution_txtExeCol5_designEditor']
${iframe.execution.execute.electronic_execution.actual_result1}    //iframe[@id='WebSplitter1_tcExecution_txtExeCol4_designEditor']
${iframe.execution.execute.electronic_execution.test.pdf_evidence}    //iframe[@id='txtevidence_designEditor']
${iframe.execution.execute.electronic_execution.exception_template}    id=EntFields_gvMain_ctl02_gvIni_ctl02_txtLTA_DesignIFrame
${iframe.execution.execute.electronic_execution.evidence}    //iframe[@id='WebSplitter1_tcExecution_divevidencetxtExeCol5_designEditor']
${iframe.execution.execute.electronic_execution.summary.execution_summary}    id=txtDescription_tw_DesignIFrame
${iframe.execution.execute.electronic_execution.summary.analysis}    id=gvSummary_ctl02_txtDescription_DesignIFrame
${iframe.execution.execute.electronic_execution.summary.conclusion}    id=gvSummary_ctl03_txtDescription_DesignIFrame
${iframe.home.document.chart.execution.view_document}    //iframe[@id="IframDoc"]
${iframe.system.create.form.control_creation.settings.helptext}    id=txtHelp_DesignIFrame
${iframe.design.feature_request.action.create.accept_criteria}    id=grdProductBackLogUserStory_ctl04_ftbTitle_DesignIFrame
${iframe.design.feature_request.story_point_assessment}    id=frameStoryPoint
${iframe.design.release_plan.create_task.description}    //iframe[contains(@id,"ftbTitle_DesignIFrame")]
${iframe.design.requirements.create_req_category}    id=dmReqIframe
${iframe.vault.view.document.doc_details}    id=libsrc
${iframe.frame.verify.mapping_screen}    //iframe[@id="iframeMapping"]
${iframe.vault.view.document.approved_doc_details}    id=frmDetails

