package com.web.spring.vo;

public class FileUse {
    private String file_key;
    private String use_type;
    private int use_key;
    private int approval_key;
    private int risk_approval_key;

    public FileUse() {
    }

    public FileUse(String file_key, String use_type, int use_key, int approval_key) {
        this.file_key = file_key;
        this.use_type = use_type;
        this.use_key = use_key;
        this.approval_key = approval_key;
    }

    public int getApproval_key() {
        return approval_key;
    }

    public void setApproval_key(int approval_key) {
        this.approval_key = approval_key;
    }

    public String getFile_key() {
        return file_key;
    }

    public void setFile_key(String file_key) {
        this.file_key = file_key;
    }

    public String getUse_type() {
        return use_type;
    }

    public void setUse_type(String use_type) {
        this.use_type = use_type;
    }

    public int getUse_key() {
        return use_key;
    }

    public void setUse_key(int use_key) {
        this.use_key = use_key;
    }

	public int getRisk_approval_key() {
		return risk_approval_key;
	}

	public void setRisk_approval_key(int risk_approval_key) {
		this.risk_approval_key = risk_approval_key;
	}
    
}
