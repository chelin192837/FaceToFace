package com.macro.mall.model;

import java.util.Date;

public class FacTeachCard {
    private Long id;

    private String user_id;

    private String icon;

    private String file_url1;

    private String file_url2;

    private String file_url3;

    private String status;

    private String remark;

    private Date create_time;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id == null ? null : user_id.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public String getFile_url1() {
        return file_url1;
    }

    public void setFile_url1(String file_url1) {
        this.file_url1 = file_url1 == null ? null : file_url1.trim();
    }

    public String getFile_url2() {
        return file_url2;
    }

    public void setFile_url2(String file_url2) {
        this.file_url2 = file_url2 == null ? null : file_url2.trim();
    }

    public String getFile_url3() {
        return file_url3;
    }

    public void setFile_url3(String file_url3) {
        this.file_url3 = file_url3 == null ? null : file_url3.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Date getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Date create_time) {
        this.create_time = create_time;
    }
}
