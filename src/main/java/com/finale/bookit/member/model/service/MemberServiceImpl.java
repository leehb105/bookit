package com.finale.bookit.member.model.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finale.bookit.member.model.dao.MemberDao;
import com.finale.bookit.member.model.vo.Address;
import com.finale.bookit.member.model.vo.Member;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional(rollbackFor=Exception.class)
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}
	
	@Override
	public int insertMember(Member member, Address address) {
		int result = memberDao.insertMember(member);
		if (result > 0) {
			result = insertAddress(address);
		}
		
		return result;
	}

	@Override
	public Member selectOneMember(String id) {
		return memberDao.selectOneMember(id);
	}

	@Override
	public int insertAddress(Address address) {
		return memberDao.insertAddress(address);
	}
	
	@Override
	public int updateAddress(Address address) {
		return memberDao.updateAddress(address);
	}

	@Override
	public int memberUpdate(Map<String, Object> param, Address address) {
		int result = memberDao.memberUpdate(param);
		if (result > 0) {
			// 주소가 없는 사람한테는 현재 적용불가
			// address 테이블에 주소가 있는지 확인하는 과정이 필요함
			result = updateAddress(address);
		}
		return result;
	}

	@Override
	public int selectOneMemberCount(String id) {
		return memberDao.selectOneMemberCount(id);
	}

	@Override
	public int selectOneMemberNicknameCount(String nickname) {
		return memberDao.selectOneMemberNicknameCount(nickname);
	}

	//카카오 토큰발급
	@Override
	public String getAccessToken(String code) {
		String access_Token = "";
        String refresh_Token = "";
        String reqURL = "https://kauth.kakao.com/oauth/token";

        try {
            URL url = new URL(reqURL);

            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            //  URL연결은 입출력에 사용 될 수 있고, POST 혹은 PUT 요청을 하려면 setDoOutput을 true로 설정해야함.
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            //	POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
            BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
            StringBuilder sb = new StringBuilder();
            sb.append("grant_type=authorization_code");
            sb.append("&client_id=8a451c649411be3540e7cd703568efbf");  // 발급받은 key
            sb.append("&redirect_uri=http://localhost:9090/bookit/member/kakao");     // 리다이렉트 경로
            sb.append("&code=" + code);
            bw.write(sb.toString());
            bw.flush();

            //    결과 코드가 200이라면 성공
            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            //    요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            //    Gson 라이브러리에 포함된 클래스로 JSON파싱 객체 생성
            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            access_Token = element.getAsJsonObject().get("access_token").getAsString();
            refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();

            System.out.println("access_token : " + access_Token);
            System.out.println("refresh_token : " + refresh_Token);

            br.close();
            bw.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return access_Token;
    }

	//카카오 유저정보조회
	@Override
	public Member getUserInfo(String access_Token) {
//	    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
        HashMap<String, Object> userInfo = new HashMap<String, Object>();
        String reqURL = "https://kapi.kakao.com/v2/user/me";
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            //    요청에 필요한 Header에 포함될 내용
            conn.setRequestProperty("Authorization", "Bearer " + access_Token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line = "";
            String result = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println("response body : " + result);

            JsonParser parser = new JsonParser();
            JsonElement element = parser.parse(result);

            JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
            JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();

            String nickname = properties.getAsJsonObject().get("nickname").getAsString();
            String email = kakao_account.getAsJsonObject().get("email").getAsString();
            
            userInfo.put("accessToken", access_Token);
            userInfo.put("nickname", nickname);
            userInfo.put("email", email);

        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

 		Member result = memberDao.findkakao(userInfo);
 		// 위 코드는 먼저 정보가 저장되있는지 확인하는 코드.
 		System.out.println("S:" + result);
 		if(result==null) {
 		// result가 null이면 정보가 저장이 안되있는거므로 정보를 저장.
 			memberDao.kakaoinsert(userInfo);
 			// 위 코드가 정보를 저장하기 위해 Repository로 보내는 코드임.
 			return memberDao.findkakao(userInfo);
 			// 위 코드는 정보 저장 후 컨트롤러에 정보를 보내는 코드임.
 			//  result를 리턴으로 보내면 null이 리턴되므로 위 코드를 사용.
 		} else {
 			return result;
 			// 정보가 이미 있기 때문에 result를 리턴함.
 		}
	}

	
}
