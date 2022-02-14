package com.finale.bookit.search.model.service;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.finale.bookit.booking.model.vo.BookInfo;
import com.finale.bookit.search.model.dao.SearchDao;
import com.finale.bookit.search.model.vo.BookReview;
import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class SearchServiceImpl implements SearchService{
	
	@Autowired
	private SearchDao searchDao;

	private final String SEARCH_URL = "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?";
	private final String SEARCH_URL_ISBN13 = "http://www.aladin.co.kr/ttb/api/ItemLookUp.aspx?";
//"http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbleesonge951614001&Query=개미 2&QueryType=Title&MaxResults=10&start=1&SearchTarget=Book&output=js&Version=20131101&Cover=MidBig";
	private final String TTB_KEY = "ttbleesonge951614001";
	

	@Override
	public String searchBookByTitle(String keyword) {
		StringBuffer result = new StringBuffer();

        try {
        	//공백처리
        	String title = URLEncoder.encode(keyword, "utf-8");
            String apiUrl = SEARCH_URL 
            		+ "ttbkey="
            		+ TTB_KEY
            		+ "&Query="
            		+ title
            		+ "&QueryType=Title"
            		+ "&MaxResults=30"
            		+ "&start=1"
            		+ "&SearchTarget=Book"
            		+ "&output=js"
            		+ "&Version=20131101"
            		+ "&Cover=MidBig";
            
            URL url = new URL(apiUrl);
            HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
            urlConnection.connect();
            BufferedInputStream bufferedInputStream = new BufferedInputStream(urlConnection.getInputStream());
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(bufferedInputStream, "UTF-8"));
            String returnLine;
            while((returnLine = bufferedReader.readLine()) != null) {
                result.append(returnLine);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result.toString();
	}
	
	
	@Override
	public int searchBookPageByIsbn13(String isbn13) {
		StringBuffer result = new StringBuffer();
		int itemPage = 0;
		try {
			String apiUrl = SEARCH_URL_ISBN13
					+ "ttbkey="
					+ TTB_KEY
					+ "&itemIdType=isbn13"
					+ "&ItemId="
					+ isbn13
					+ "&output=js"
					+ "&Version=20131101";

//			log.debxug("apiUrl = {}", apiUrl);
			URL url = new URL(apiUrl);
			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.connect();
			BufferedInputStream bufferedInputStream = new BufferedInputStream(urlConnection.getInputStream());
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(bufferedInputStream, "UTF-8"));
			String returnLine;
			while((returnLine = bufferedReader.readLine()) != null) {
				result.append(returnLine);
			}
			
			JSONObject json = new JSONObject(result.toString());
//			log.debug("result = {}", result);
			itemPage = json.getJSONArray("item").getJSONObject(0).getJSONObject("subInfo").getInt("itemPage");
//			log.debug("item = {}", item);
//			log.debug("itemPage = {}",  itemPage);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return itemPage;
	}
	
	@Override
	public int searchBookPageByIsbn10(String isbn10) {
		StringBuffer result = new StringBuffer();
		int itemPage = 0;
		try {
			String apiUrl = SEARCH_URL_ISBN13
					+ "ttbkey="
					+ TTB_KEY
					+ "&itemIdType=isbn"
					+ "&ItemId="
					+ isbn10
					+ "&output=js"
					+ "&Version=20131101";
			
//			log.debxug("apiUrl = {}", apiUrl);
			URL url = new URL(apiUrl);
			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.connect();
			BufferedInputStream bufferedInputStream = new BufferedInputStream(urlConnection.getInputStream());
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(bufferedInputStream, "UTF-8"));
			String returnLine;
			while((returnLine = bufferedReader.readLine()) != null) {
				result.append(returnLine);
			}
			
			JSONObject json = new JSONObject(result.toString());
//			log.debug("result = {}", result);
			itemPage = json.getJSONArray("item").getJSONObject(0).getJSONObject("subInfo").getInt("itemPage");
//			log.debug("item = {}", item);
//			log.debug("itemPage = {}",  itemPage);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return itemPage;
	}


	@Override
	public String searchBookByIsbn13(String isbnNum) {
		StringBuffer result = new StringBuffer();
		final String ISBN = "isbn";
		final String ISBN13 = "isbn13";
		
		try {
			String apiUrl = null;
			//isbn13일경우 주소 
			if(isbnNum.length() == 13) {
				apiUrl = SEARCH_URL_ISBN13
						+ "ttbkey="
						+ TTB_KEY
						+ "&itemIdType="
						+ ISBN13
						+ "&ItemId="
						+ isbnNum
						+ "&Cover=MidBig"
						+ "&output=js"
						+ "&Version=20131101";
			}else {
				apiUrl = SEARCH_URL_ISBN13
						+ "ttbkey="
						+ TTB_KEY
						+ "&itemIdType="
						+ ISBN
						+ "&ItemId="
						+ isbnNum
						+ "&Cover=MidBig"
						+ "&output=js"
						+ "&Version=20131101";
			}

//			log.debxug("apiUrl = {}", apiUrl);
			URL url = new URL(apiUrl);
			HttpURLConnection urlConnection = (HttpURLConnection) url.openConnection();
			urlConnection.connect();
			BufferedInputStream bufferedInputStream = new BufferedInputStream(urlConnection.getInputStream());
			BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(bufferedInputStream, "UTF-8"));
			String returnLine;
			while((returnLine = bufferedReader.readLine()) != null) {
				result.append(returnLine);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result.toString();
	}


	@Override
	public List<BookReview> selectBookReviewByIsbn(HashMap<String, Object> param) {
		return searchDao.selectBookReviewByIsbn(param);
	}

	@Override
	public int selectTotalBookReviewCount(HashMap<String, Object> param) {
		return searchDao.selectTotalBookReviewCount(param);
	}


	@Override
	public int selectReviewIdCount(HashMap<String, Object> param) {
		return searchDao.selectReviewIdCount(param);
	}


	@Override
	public int bookReviewEnroll(HashMap<String, Object> param) {
		return searchDao.bookReviewEnroll(param);
	}

	






}
