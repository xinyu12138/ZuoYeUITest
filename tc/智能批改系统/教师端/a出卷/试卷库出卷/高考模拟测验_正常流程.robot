*** Keywords ***
suite setup action
    bookmark   高考模拟测验_正常流程            # 试卷库出卷
    SubmitHomeWork   高考模拟测验_正常流程      # 提交作业
    changehandle  管理后台
    ChooseTest    高考模拟测验_正常流程
    TuPianYuChuLi
    TuPianYuXueSheng
    DealwithUnNo   高考模拟测验_正常流程   # 教师处理那一个未关联的学生
    # 图片与成绩下的题目处理
    XuanZeTi
    TianKongTi
    GaiCuoTi
    # ZuoWenTi 作文题不需要标注
    DaFenKuang
    ShiJuanDaFen
    # 图片与成绩下的题目处理
    XueShengChengJi
    sleep  1

*** Settings ***
Library  Collections
Variables  cfg.py
Library  pylib.WebOpTeacher
Library  pylib.Toolkit
Library  pylib.WebOpAdmin
Library  pylib.PrepareExercise
Library  pylib.WebOp
Library  pylib.DealwithExam.PictureAndGrade
Library  pylib.DealwithExam.DealwithExam

Suite Setup  suite setup action
Suite Teardown  run keywords  deleteexcise  高考模拟测验_正常流程  查看成绩
                ...      AND  ChangeHandle        管理后台
                ...      AND  DeleteAdminExcise   高考模拟测验_正常流程
                ...      AND  ChangeHandle        智能批改


*** Test Cases ***
流程-提交作业 - tc1005
    bookmark   高考模拟测验_正常流程       # 试卷库出卷
    SubmitHomeWork   高考模拟测验_正常流程      # 提交作业
    ${compare}=   mygettext   //span[text()="正在努力批改中"]
    should be true  u"${compare}" == u"正在努力批改中"
    changehandle  管理后台

    [Teardown]  run keywords  deleteexcise  高考模拟测验_正常流程  作业批改中
                ...      AND  ChangeHandle        管理后台
                ...      AND  DeleteAdminExcise   高考模拟测验_正常流程
                ...      AND  ChangeHandle        智能批改

流程-删除练习 - tc1004
    bookmark   高考模拟测验_正常流程
    DeleteExcise   高考模拟测验_正常流程  请提交作业
    is not visible   //div[@class="inline ng-scope"]/button
    ${compare}=   mygettext  //div/button
    should be true  u"${compare}" == u"布置新作业"
    [Teardown]  run keywords  ChangeHandle        管理后台
                ...      AND  DeleteAdminExcise   高考模拟测验_正常流程
                ...      AND  ChangeHandle        智能批改

流程-后台发布成绩 - tc2001
    bookmark   高考模拟测验_正常流程            # 试卷库出卷
    SubmitHomeWork   高考模拟测验_正常流程      # 提交作业
    changehandle  管理后台
    ChooseTest    高考模拟测验_正常流程
    TuPianYuChuLi
    TuPianYuXueSheng
    DealwithUnNo   高考模拟测验_正常流程   # 教师处理那一个未关联的学生
    # 图片与成绩下的题目处理
    XuanZeTi
    TianKongTi
    GaiCuoTi
    # ZuoWenTi 作文题不需要标注
    DaFenKuang
    ShiJuanDaFen
    # 图片与成绩下的题目处理
    XueShengChengJi
    sleep  1
    ${compare}=  mygettext  //div[@class="toast-inner"]
    should be true  u"${compare}" == u"发布成功"
    [Teardown]  run keywords  DeleteAdminExcise   高考模拟测验_正常流程
                ...      AND  ChangeHandle        智能批改
                ...      AND  deleteexcise        高考模拟测验_正常流程  查看成绩

流程-下载各个报告 - tc1006
    ChangeHandle  智能批改
    DownloadFile  高考模拟测验_正常流程      #d_SU高中英语（模板出卷）


流程-检查总分 - tc1007
    ChangeHandle  智能批改
    ${scores}=  GetGradeScore  高考模拟测验_正常流程
    log to console  ${scores}
    ${compareScore}=  create list  92.9  141  10
    lists should be equal  ${scores}  ${compareScore}




