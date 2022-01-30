package com.finale.bookit.booking.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BookInfo {
    private String isbn13;
    private String title;
    private String author;
    private String publisher;
    private Date pubdate;
    private int itemPage;
    private String categoryName;
    private String toc;
    private String cover;
    private String description;

}