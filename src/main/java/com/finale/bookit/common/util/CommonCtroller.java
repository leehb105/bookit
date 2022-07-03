package com.finale.bookit.common.util;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CommonCtroller {
    @RequestMapping(value = "/error/accessError.do", method = RequestMethod.GET)
    public void accessError(){
    }
}
