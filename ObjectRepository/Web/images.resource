*** Settings ***
Documentation     This image file has all image type locators of web application


*** Variables ***
# robocop: disable=section-variable-not-uppercase
${web.img.vlms.vg_logo}    //img[@src="../App_Themes/VGBlue/Images/VG-logo-Doc.gif"]
${web.img.vlms.content.author.doc.plugins.option}    //span[text()='replaceText']/parent::div/preceding-sibling::div//img
${web.img.vlms.loading_document}    id=loadmask-spinner
${img.content_generation.process_flow.decision_tree_diagram}    //div[@id="DecistionTree_diagramView"]
${web.img.view_icon.view_details.sort}    //*[@alt='replaceText']
${img.add_info.workflow.diagram}    //div[@class='workflowsub']/div/*
${img.content.create.trace_model}    //div[@class="matrix-block"]
${img.project.create.define.entity.next_page}    //img[@class='dxWeb_pNext']
${img.phase.project.update.project}    //img[@id='imgmoreinformation1']
${img.expand.content.author.content.library}    //img[@id='imgpnlselecttestfnstodev']
${img.project.create.deliverables.duplicate}    //span[text()='replaceText1']//ancestor::tr//td//span[text()='replaceText2']//ancestor::tr//td//div//input[contains(@id,'Duplicate')]
${img.report.create.ad_hoc_report.preview_bar_chart}    //div[@id='chartDiv_0']//*[name()='svg']//*[name()='g']//*[name()='path' and @fill='replaceText']
${img.assessment.assigned.validatedeliverables.update.remove}    //a[@id='grvValidationtype_ctl01_lnkRemove']
${img.assessment.assigned.define.close}    //button[@id='canvas_close']//img[contains(@class,'close-icon')]
${img.content.author.external_document.word.insert.table}    //i[contains(@class,'inserttable')]
${img.vault.view.document.approved_doc_details.table.pdf}    //a[@id='gvDocumentDetails_ctl02_lnbtnPdf']//img
