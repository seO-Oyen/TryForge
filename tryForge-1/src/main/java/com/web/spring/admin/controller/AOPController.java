package com.web.spring.admin.controller;

import com.web.spring.admin.service.AOPService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AOPController {
    @Autowired(required = false)
    private AOPService service;

    @GetMapping("errorList")
    public String errorList(Model d){
        d.addAttribute("elist",service.errorList());
        return "AOPError/errorList";
    }
    @GetMapping("confirmError")
    public String confirmError(@RequestParam("error_key")int error_key, Model d){
        d.addAttribute("uptMsg",service.ConfirmError(error_key));
        return "pageJsonReport";
    }
}
