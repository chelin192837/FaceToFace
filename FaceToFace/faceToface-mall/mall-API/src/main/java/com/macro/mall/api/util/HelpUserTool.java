package com.macro.mall.api.util;

import com.macro.mall.model.FacStudent;

public class HelpUserTool {

    //类初始化时，不初始化这个对象(延时加载，真正用的时候再创建)
    private static HelpUserTool instance;

    //构造器私有化
    private HelpUserTool(){}

    //方法同步，调用效率低
    public static synchronized HelpUserTool getInstance(){

        if(instance==null){
            instance=new HelpUserTool();
        }

        return instance;

    }

    private FacStudent facStudent;

    public void setFacStudent(FacStudent facStudent) {
        this.facStudent = facStudent;
    }

    public FacStudent getFacStudent() {
        return this.facStudent;
    }

    public FacStudent user()
    {
        return this.facStudent;
    }

    public void setUser(FacStudent student)
    {
        this.facStudent = student;
    }


}
