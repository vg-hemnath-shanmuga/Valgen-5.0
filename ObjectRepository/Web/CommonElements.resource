*** Settings ***
Documentation     This Checkboxes file has all checkbox type locators of web application

*** Variables ***
${common.missing.text}    //div[contains(text(),'replaceText')]
${common.expand.status.button}    //a[@id='lnkFilter']
${common.dropdown.filter.selection}    //span[text()='replaceText']/parent::a/i
${common.dropdown.filter.selection.option}    //label[text()='replaceText']/parent::td/input
${common.link.table.search}    //span[text()='replaceText1']/parent::td/preceding-sibling::td/span/font[text()='replaceText2']/parent::span/parent::td/preceding-sibling::td/a|//span[text()='replaceText1']/parent::td/preceding-sibling::td/span[text()='replaceText2']/parent::td/preceding-sibling::td/a|//span[text()='replaceText1']/parent::td/preceding-sibling::td/a/font[text()='replaceText2']/parent::a|//span[contains(text(),'replaceText1')]/parent::td/preceding-sibling::td/a/font[text()='replaceText2']/parent::a|//span[starts-with(text(),"replaceText1")]/parent::td/preceding-sibling::td/a/font[text()='replaceText2']/parent::a|//span[contains(text(),'replaceText1')]/parent::td/preceding-sibling::td/span/font[text()='replaceText2']/parent::span/parent::td/preceding-sibling::td/a
${common.traget.date.input}    id=txtBoxTargetDate_I
${common.traget.date.calender.img}    //td[@id='txtBoxTargetDate_B-1']
${common.traget.date.selected}    //td[contains(@class,'dxeCalendarDay') and contains(@class,'dxeCalendarSelected')]
${common.label.review.flow}    (//tr/td//input[contains(@id,'_rdoRevreplaceText2')]/following-sibling::label)[replaceText1]
${common.label.approve.flow}    (//tr/td//input[contains(@id,'_rdoAppreplaceText2')]/following-sibling::label)[replaceText1]
${common.radio.review.flow}    (//tr/td//input[contains(@id,'_rdoRevreplaceText2')])[replaceText1]
${common.radio.approve.flow}    (//tr/td//input[contains(@id,'_rdoAppreplaceText2')])[replaceText1]
${common.missing.text}    //div[contains(text(),'replaceText')]
${common.expand.status.button}    //a[@id='lnkFilter']
${common.dropdown.filter.selection}    //span[text()='replaceText']/parent::a/i
${common.dropdown.filter.selection.option}    //label[text()='replaceText']/parent::td/input
${common.link.table.search}    //span[text()='replaceText1']/parent::td/preceding-sibling::td/span/font[text()='replaceText2']/parent::span/parent::td/preceding-sibling::td/a|//span[text()='replaceText1']/parent::td/preceding-sibling::td/span[text()='replaceText2']/parent::td/preceding-sibling::td/a|//span[text()='replaceText1']/parent::td/preceding-sibling::td/a/font[text()='replaceText2']/parent::a|//span[contains(text(),'replaceText1')]/parent::td/preceding-sibling::td/a/font[text()='replaceText2']/parent::a|//span[starts-with(text(),"replaceText1")]/parent::td/preceding-sibling::td/a/font[text()='replaceText2']/parent::a|//span[contains(text(),'replaceText1')]/parent::td/preceding-sibling::td/span/font[text()='replaceText2']/parent::span/parent::td/preceding-sibling::td/a
${common.traget.date.input}    id=txtBoxTargetDate_I
${common.traget.date.calender.img}    //td[@id='txtBoxTargetDate_B-1']
${common.traget.date.selected}    //td[contains(@class,'dxeCalendarDay') and contains(@class,'dxeCalendarSelected')]
${common.label.review.flow}    (//tr/td//input[contains(@id,'_rdoRevreplaceText2')]/following-sibling::label)[replaceText1]
${common.label.approve.flow}    (//tr/td//input[contains(@id,'_rdoAppreplaceText2')]/following-sibling::label)[replaceText1]
${common.radio.review.flow}    (//tr/td//input[contains(@id,'_rdoRevreplaceText2')])[replaceText1]
${common.radio.approve.flow}    (//tr/td//input[contains(@id,'_rdoAppreplaceText2')])[replaceText1]
${toastmessage.popup.verify.common}    //div[@id='liveToast']
${toast.common.verify Message}    //span[@id='toastBody']
${spreadtemplate.Text}    //*[@id="txtBoxName"]
${list.system.create.form.form_applicable.select_all}    //li[contains(@class,'active-result') and contains(text(),'Select All')]
${list.system.create.form.form_applicable_to.type}    //li[contains(@class,'active-result') and contains(text(),'replaceText')]
${tab.system.create.decision_tree.business_rule_riskassess}    //*[@id='dynamicMainTab']/li
${table.crosssiteprofile.selectedusers}    //table[@class="table table-bordered grid-view-hover"]
${list.validation_standard.decision_tree}    //li[not(contains(@class,'result-selected')) and (text()='replaceText')]
${sectiontext}    //table[@id='UltraWebTab1_grvSections']/tbody/tr/td/div/div/span[1]
${table.Criticality Assessment.length.risk.create.risk framework}    //table[@id='gvSelectedColumn']/tbody/tr
${tab.template.id}    //span[@id='txtTemplateNo']|//span[@id='txtTemplateNo']|//a[@id='lnkWebDocument']
${body.template.description}    //body[@class='dxheDesignViewArea dxheViewArea dxhe-docTypeXHTML']
${web.img.vlms.vg_logo}    //img[@src="../App_Themes/VGBlue/Images/VG-logo-Doc.gif"]
${web.img.vlms.content.author.doc.plugins.option}    //span[text()='replaceText']/parent::div/preceding-sibling::div//img
${web.img.vlms.loading_document}    id=loadmask-spinner
${web.img.view_icon.view_details.sort}    //*[@alt='replaceText']
${riskprocess.common}    //label[text()="replaceText"]
${tab.Activateuser.Administartion.User}    //span[text()='Activate User']
${table.dropdown.select.common}    //td[@id="replaceText"]
${dropdown.table.common.select.value}    //td[contains(@class,'dxeLTM') and contains(text(),"replaceText")]
${tab.template.create}    //span[@id='lblCreateheader']  