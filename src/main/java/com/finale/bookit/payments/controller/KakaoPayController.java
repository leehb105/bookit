package com.finale.bookit.payments.controller;

import java.beans.PropertyEditor;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.finale.bookit.payments.model.service.PaymentsService;
import com.finale.bookit.payments.model.vo.KakaoPay;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@PropertySource("classpath:/iamport.properties")
//@PropertySource("classpath:iamport.properties") // 슬래시(/)없이 시작해도 작동함
//https://needjarvis.tistory.com/595
public class KakaoPayController {

	@Autowired
	private PaymentsService paymentsService;
	
	// iamport.properties에서 속성값 불러오기
	@Value("${iamport.uid}")
	private String iamportUid;
	
	@Value("${iamport.apiKey}")
	private String apiKey;
	
	@Value("${iamport.apiSecret}")
	private String apiSecret;

	
	// 북토리 충전 페이지
	@GetMapping(value="/member/payments/charge.do")
	public void charge(Model model) {
		model.addAttribute("iamportUid", iamportUid);
	}

//	https://okky.kr/article/361093
//	https://despacito-pasito.tistory.com/8
	@PostMapping(value="/member/payments/charge.do", produces="application/text; charset=UTF-8")
	@ResponseBody
	public String chargeComplete(@RequestBody KakaoPay body, Model model) {
		log.debug("kakaoPay = {} ", body.toString());
		
		// 충전금액 위변조 검증을 위한 토큰 획득
		final String token = this.getToken();
		
		// 위변조 검증
		if(this.isCounterfeited(body, token))
			return "결제 실패(사유: 위변조 시도)";

		body.setBonusCash((int) (body.getChargeCash() * 0.03));
		int result = paymentsService.insertCash(body);
		
		return String.valueOf(body.getChargeCash() + body.getBonusCash());
	
	}
	
	@GetMapping(value="/member/payments/history.do")
	public void history(Authentication authentication, Model model) {
		log.debug("authentication = {}", authentication);
		List<KakaoPay> list = paymentsService.selectHistoryList();
		
		model.addAttribute("list", list);
	}
	
	public String getToken() {

		final String url = "https://api.iamport.kr/users/getToken";
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("imp_key", apiKey);
		params.add("imp_secret", apiSecret);
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Type", "multipart/form-data");
		
		HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(params, headers);
		
		RestTemplate rt = new RestTemplate();
		ResponseEntity<String> response = rt.exchange(url, HttpMethod.POST, entity, String.class);

		log.debug("response = {}", response);
		
		JSONObject jObject = new JSONObject(response.getBody());
		return jObject.getJSONObject("response").getString("access_token");
		
	}
	
	public boolean isCounterfeited(KakaoPay body, String access_token) {

		final String url = "https://api.iamport.kr/payments/" + body.getImpUid() + "?_token=" + access_token;
		
		RestTemplate rt = new RestTemplate();
		ResponseEntity<String> response = rt.getForEntity(url, String.class); 

//		https://codechacha.com/ko/java-parse-json/
		JSONObject jObject = new JSONObject(response.getBody()).getJSONObject("response");
		
		int amount = jObject.getInt("amount");
		String impUid = jObject.getString("imp_uid");
		
		log.debug("amount = {}원", amount);
		log.debug("impUid = {}", impUid);
		log.debug("body.cash = {}", body.getChargeCash());
		log.debug("body.impuid = {}", body.getImpUid());

		return (amount != body.getChargeCash() || !impUid.equals(body.getImpUid()));
	}
}
