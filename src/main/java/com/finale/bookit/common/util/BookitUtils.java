package com.finale.bookit.common.util;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletWebRequest;

import com.finale.bookit.member.model.vo.Member;

public class BookitUtils {

	
	public static String rename(String originalFilename) {
		// 새파일명 생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
		DecimalFormat df = new DecimalFormat("000");
		
		// 확장자명
		String ext = "";
		int dot = originalFilename.lastIndexOf(".");
		if(dot > -1)
			ext = originalFilename.substring(dot);
		
		return sdf.format(new Date()) + df.format(Math.random() * 999) + ext;
	}
	
	
	
	/**
	 * 
	 * @param cPage
	 * @param numPerPage
	 * @param totalContent
	 * @param url
	 * 
	 * totalPage 전체페이지
	 * pagebarSize 페이지바 크기 5
	 * pageNo
	 * pageStart - pageEnd
	 * 
	 * @return
	 */
	public static String getPagebar(int cPage, int numPerPage, int totalContent, String url) {
		StringBuilder pagebar = new StringBuilder(); 
		
		if(url.startsWith("/bookit/collection/collectionDetail.do?no=")) {
			url = url + "&cPage="; // 컬렉션 내부에서의 페이징
		}
		else {
			url = url + "?cPage="; // pageNo 추가전 상태			
		}
		
		final int pagebarSize = 5;
		final int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		final int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		pageEnd = totalPage < pageEnd ? totalPage : pageEnd;
		int pageNo = pageStart;

		/*
		 	<nav>
			  <ul class="pagination">
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			        <span class="sr-only">Previous</span>
			      </a>
			    </li>
			    <li class="page-item"><a class="page-link" href="#">1</a></li>
			    <li class="page-item active"><a class="page-link" href="#">2</a></li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
			    <li class="page-item">
			      <a class="page-link" href="#" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			        <span class="sr-only">Next</span>
			      </a>
			    </li>
			  </ul>
			</nav>
		 */
		pagebar.append("<nav\r\n"
				+ "			  <ul class=\"pagination justify-content-center pagination-sm\">\r\n"
				+ "			    ");
		
		
		// [이전]
		if(pageNo == 1) {
			// 이전 영역 비활성화
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "			      <a class=\"page-link\" href=\"javascript:paging(" + (pageNo - 1) + ");\" aria-label=\"Previous\">\r\n"
					+ "			        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "			        <span class=\"sr-only\">Previous</span>\r\n"
					+ "			      </a>\r\n"
					+ "			    </li>");
		}
		else {
			// 이전 영역 활성화
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "			      <a class=\"page-link\" href=\"javascript:paging(" + (pageNo - 1) + ");\" aria-label=\"Previous\">\r\n"
					+ "			        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "			        <span class=\"sr-only\">Previous</span>\r\n"
					+ "			      </a>\r\n"
					+ "			    </li>");
		}
		
		// pageNo
		while(pageNo <= pageEnd) {
			if(pageNo == cPage) {
				// 현재페이지
				pagebar.append("<li class=\"page-item active\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">" + pageNo + "</a></li>\r\n");
			}
			else {
				// 현재페이지가 아닌 경우
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">" + pageNo + "</a></li>\r\n");
			}
			
			pageNo++;
		}
		
		
		// [다음]
		if(pageNo > totalPage) {
			// 다음 페이지 비활성화
			pagebar.append("<li class=\"page-item disabled\">\r\n"
					+ "			      <a class=\"page-link\" href=\"#\" aria-label=\"Next\">\r\n"
					+ "			        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "			        <span class=\"sr-only\">Next</span>\r\n"
					+ "			      </a>\r\n"
					+ "			    </li>\r\n"
					+ "			  ");
		}
		else {
			// 다음 페이지 활성화
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "			      <a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\" aria-label=\"Next\">\r\n"
					+ "			        <span aria-hidden=\"true\">&raquo;</span>\r\n"
					+ "			        <span class=\"sr-only\">Next</span>\r\n"
					+ "			      </a>\r\n"
					+ "			    </li>\r\n"
					+ "			  ");
		}
		
		pagebar.append("			  </ul>\r\n"
				+ "			</nav>\r\n"
				+ "<script>"
				+ "const paging = (pageNo) => { location.href = `" + url + "${pageNo}`;  };"
				+ "</script>");
		return pagebar.toString();
	}
	
	//도서 검색 목록에 대한 페이징	
	public static String getPagebarBookList(int cPage, int numPerPage, int totalContent, String url) {
		
		StringBuilder pagebar = new StringBuilder(); 

		url = url + "?cPage="; // pageNo 추가전 상태			
		
		
		final int pagebarSize = 5;
		final int totalPage = (int) Math.ceil((double) totalContent / numPerPage);
		final int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1;
		int pageEnd = pageStart + pagebarSize - 1;
		pageEnd = totalPage < pageEnd ? totalPage : pageEnd;
		int pageNo = pageStart;

		pagebar.append(
					"<nav class=\"roberto-pagination mb-100\" >\n"
							+ "<ul class=\"pagination\">");
		
		
		// [이전]
		if(pageNo == 1) {
			// 이전 영역 비활성화
		}
		else {
			// 이전 영역 활성화
			pagebar.append("<li class=\"page-item\">\r\n"
					+ "			      <a class=\"page-link\" href=\"javascript:paging(" + (pageNo - 1) + ");\" aria-label=\"Previous\">\r\n"
					+ "			        <span aria-hidden=\"true\">&laquo;</span>\r\n"
					+ "			        <span class=\"sr-only\">Previous</span>\r\n"
					+ "			      </a>\r\n"
					+ "			    </li>");
		}
		
		// pageNo
		while(pageNo <= pageEnd) {
			if(pageNo == cPage) {
				// 현재페이지
				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">" + pageNo + "</a></li>\r\n");
			}
			else {
				// 현재페이지가 아닌 경우
//				pagebar.append("<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:paging(" + pageNo + ")\">" + pageNo + "</a></li>\r\n");
			}
			
			pageNo++;
		}
		
		
		// [다음]
		if(pageNo > totalPage) {
			// 다음 페이지 비활성화
		}
		else {
			// 다음 페이지 활성화

			pagebar.append("<li class=\"page-item\">\n"
					+ "				<a class=\"page-link\" href=\"javascript:paging(" + pageNo + "\")\"> >> \n"
					+ "					<i class=\"fa fa-angle-right\"></i>\n"
					+ "				</a>\n"
					+ "			</li>");
		}
		
		pagebar.append("			  </ul>\r\n"
				+ "			</nav>\r\n"
				+ "<script>"
				+ "const paging = (pageNo) => { location.href = `" + url + "${pageNo}`;  };"
				+ "</script>");
		return pagebar.toString();
	}
	
	public static String getFormatDateToString(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String newDate = sdf.format(date);
		
		return newDate;
	}
	public static String getFormatDate(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
		String newDate = sdf.format(date);
		
		return newDate;
	}
	public static Date getFormatDate(String date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date newDate = new Date();
		try {
			newDate = sdf.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return newDate;
	}
	
	public static int getTotalResults(int totalResults) {
		int itemsPerPage = 30;
		//검색결과갯수가 요청 갯수보다 많으면
		if(totalResults > itemsPerPage) {
			return itemsPerPage;
		}else {
			return totalResults;
		}
		
	}

	
	
	
}
