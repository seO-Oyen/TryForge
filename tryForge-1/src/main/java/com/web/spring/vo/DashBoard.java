package com.web.spring.vo;

public class DashBoard {
    private int task_week;
    private int total_task;
    private int completed_task;
    private int inprogress_task;

    public DashBoard() {
    }

    public DashBoard(int task_week, int total_task, int completed_task, int inprogress_task) {
        this.task_week = task_week;
        this.total_task = total_task;
        this.completed_task = completed_task;
        this.inprogress_task = inprogress_task;
    }

    public int getTask_week() {
        return task_week;
    }

    public void setTask_week(int task_week) {
        this.task_week = task_week;
    }

    public int getTotal_task() {
        return total_task;
    }

    public void setTotal_task(int total_task) {
        this.total_task = total_task;
    }

    public int getCompleted_task() {
        return completed_task;
    }

    public void setCompleted_task(int completed_task) {
        this.completed_task = completed_task;
    }

    public int getInprogress_task() {
        return inprogress_task;
    }

    public void setInprogress_task(int inprogress_task) {
        this.inprogress_task = inprogress_task;
    }
}
