package com.wxc.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * 描述：处理日期时间的格式问题
 * @author mazhonghua
 * 创建日期：2014-10-17上午10:36:58
 */
public class DateTime {
	
	// 年月格式
	public static final String YEAR_MONTH_FORMAT = "yyyy-MM";
	// 日期格式
	public static final String DATE_FORMAT = "yyyy-MM-dd";
	public static final String FORMAT_YEAR = "yyyyMMdd";
	// 时间格式
	public static final String TIME_FORMAT = "HH:mm:ss";
	// 日期时间格式
	public static final String DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss";
	//　精确时间格式
	public static final String EXACT_DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm:ss.sss";
	
	public static final String DATETIME_TO_MINUTE_FORMAT = "yyyy-MM-dd HH:mm";
	public static final String DATETIME_TO_MINUTE_NO_YEAR = "MM-dd HH:mm";
	// 获得当前时间的字符串格式
	public static String getStringCurrentTime(String pattern){
		return dateToString(new Date(), pattern);
	}
	
	// "yyyy/MM/dd HH:MM:ss"
	// String 时间转换成 Date
	public static Date stringToDate(String time,String pattern) throws ParseException{
		SimpleDateFormat df=new SimpleDateFormat(pattern);
		Date date = df.parse(time);
		return date;
	}
	
	// date类型时间转换成 string形式
	public static String dateToString(Date date,String pattern){
		SimpleDateFormat df=new SimpleDateFormat(pattern);
		String time = df.format(date);
		return time;
	}
	
	public static String getDate(String pattern){
		SimpleDateFormat df = new SimpleDateFormat(pattern);
		String date =  df.format(new Date());
		return date;
	}
	
	 /**
     * 解析一个日期之间的所有月份
     * @param beginDateStr
     * @param endDateStr
     * @return
     */
    public static ArrayList<String> getMonthList(String beginDateStr,
            String endDateStr) {
        // 指定要解析的时间格式
        SimpleDateFormat f = new SimpleDateFormat(YEAR_MONTH_FORMAT);
        // 返回的月份列表
        String sRet = "";
 
        // 定义一些变量
        Date beginDate = null;
        Date endDate = null;
 
        GregorianCalendar beginGC = null;
        GregorianCalendar endGC = null;
        ArrayList<String> list = new ArrayList<String>();
 
        try {
            // 将字符串parse成日期
            beginDate = f.parse(beginDateStr);
            endDate = f.parse(endDateStr);
 
            // 设置日历
            beginGC = new GregorianCalendar();
            beginGC.setTime(beginDate);
 
            endGC = new GregorianCalendar();
            endGC.setTime(endDate);
 
            // 直到两个时间相同
            while (beginGC.getTime().compareTo(endGC.getTime()) <= 0) {
                sRet = beginGC.get(Calendar.YEAR) + "-"
                        + (beginGC.get(Calendar.MONTH) + 1);
                list.add(sRet);
                // 以月为单位，增加时间
                beginGC.add(Calendar.MONTH, 1);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
 
    /**
     * 解析一个日期段之间的所有日期
     * @param beginDateStr 开始日期
     * @param endDateStr  结束日期
     * @return
     */
    public static ArrayList<String> getDayList(String beginDateStr,
            String endDateStr) {
        // 指定要解析的时间格式
        SimpleDateFormat f = new SimpleDateFormat(DATE_FORMAT);
 
        // 定义一些变量
        Date beginDate = null;
        Date endDate = null;
 
        Calendar beginGC = null;
        Calendar endGC = null;
        ArrayList<String> list = new ArrayList<String>();
 
        try {
            // 将字符串parse成日期
            beginDate = f.parse(beginDateStr);
            endDate = f.parse(endDateStr);
 
            // 设置日历
            beginGC = Calendar.getInstance();
            beginGC.setTime(beginDate);
 
            endGC = Calendar.getInstance();
            endGC.setTime(endDate);
            SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
 
            // 直到两个时间相同
            while (beginGC.getTime().compareTo(endGC.getTime()) <= 0) {
 
                list.add(sdf.format(beginGC.getTime()));
                // 以日为单位，增加时间
                beginGC.add(Calendar.DAY_OF_MONTH, 1);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
 
    public static ArrayList<Integer> getYearList() {
        ArrayList<Integer> list = new ArrayList<Integer>();
        Calendar c = null;
        c = Calendar.getInstance();
        c.setTime(new Date());
        int currYear = Calendar.getInstance().get(Calendar.YEAR);
 
        int startYear = currYear - 5;
        int endYear = currYear + 10;
        for (int i = startYear; i < endYear; i++) {
            list.add(new Integer(i));
        }
        return list;
    }
 
    public static int getCurrYear() {
        return Calendar.getInstance().get(Calendar.YEAR);
    }
 
    /**
     * 得到某一年周的总数
     * @param year
     * @return
     */
    public static LinkedHashMap<Integer, String> getWeekList(int year) {
        LinkedHashMap<Integer, String> map = new LinkedHashMap<Integer, String>();
        Calendar c = new GregorianCalendar();
        c.set(year, Calendar.DECEMBER, 31, 23, 59, 59);
        int count = getWeekOfYear(c.getTime());
 
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        String dayOfWeekStart = "";
        String dayOfWeekEnd = "";
        for (int i = 1; i <= count; i++) {
            dayOfWeekStart = sdf.format(getFirstDayOfWeek(year, i));
            dayOfWeekEnd = sdf.format(getLastDayOfWeek(year, i));
            map.put(new Integer(i), "第" + i + "周(从" + dayOfWeekStart + "至"
                    + dayOfWeekEnd + ")");
        }
        return map;
 
    }
 
    /**
     * 得到一年的总周数
     * @param year
     * @return
     */
    public static int getWeekCountInYear(int year) {
        Calendar c = new GregorianCalendar();
        c.set(year, Calendar.DECEMBER, 31, 23, 59, 59);
        int count = getWeekOfYear(c.getTime());
        return count;
    }
 
    /**
     * 取得当前日期是多少周
     * @param date
     * @return
     */
    public static int getWeekOfYear(Date date) {
        Calendar c = new GregorianCalendar();
        c.setFirstDayOfWeek(Calendar.SUNDAY);
        c.setMinimalDaysInFirstWeek(7);
        c.setTime(date);
        return c.get(Calendar.WEEK_OF_YEAR);
    }
 
    /**
     * 得到某年某周的第一天
     * @param year
     * @param week
     * @return
     */
    public static Date getFirstDayOfWeek(int year, int week) {
        Calendar c = new GregorianCalendar();
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONDAY, Calendar.JANUARY);
        c.set(Calendar.DATE, 1);
        Calendar cal = (GregorianCalendar) c.clone();
        cal.add(Calendar.DATE, week * 7);
        return getFirstDayOfWeek(cal.getTime());
    }
 
    /**
     * 得到某年某周的最后一天
     * @param year
     * @param week
     * @return
     */
    public static Date getLastDayOfWeek(int year, int week) {
        Calendar c = new GregorianCalendar();
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONDAY, 0);
        c.set(Calendar.DATE, 1);
        Calendar cal = (GregorianCalendar) c.clone();
        cal.add(Calendar.DATE, week * 7);
        return getLastDayOfWeek(cal.getTime());
    }
 
    /**
     * 得到某年某月的第一天
     * @param year
     * @param month
     * @return
     */
    public static Date getFirestDayOfMonth(int year, int month) {
        month = month - 1;
        Calendar c = Calendar.getInstance();
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, month);
        @SuppressWarnings("static-access")
        int day = c.getActualMinimum(c.DAY_OF_MONTH);
        c.set(Calendar.DAY_OF_MONTH, day);
        return c.getTime();
 
    }
 
    /**
     * 提到某年某月的最后一天
     * @param year
     * @param month
     * @return
     */
    public static Date getLastDayOfMonth(int year, int month) {
        month = month - 1;
        Calendar c = Calendar.getInstance();
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, month);
        @SuppressWarnings("static-access")
        int day = c.getActualMaximum(c.DAY_OF_MONTH);
        c.set(Calendar.DAY_OF_MONTH, day);
        return c.getTime();
    }
 
    /**
     * 取得当前日期所在周的第一天
     * @param date
     * @return
     */
    public static Date getFirstDayOfWeek(Date date) {
        Calendar c = new GregorianCalendar();
        c.setFirstDayOfWeek(Calendar.SUNDAY);
        c.setTime(date);
        c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek()); // Monday
        return c.getTime();
    }
 
    /**
     * 取得当前日期所在周的最后一天
     * @param date
     * @return
     */
    public static Date getLastDayOfWeek(Date date) {
        Calendar c = new GregorianCalendar();
        c.setFirstDayOfWeek(Calendar.SUNDAY);
        c.setTime(date);
        c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek() + 6); // Sunday
        return c.getTime();
    }
 
    /**
     * 得到某年某季度第一天
     * @param year
     * @param quarter
     * @return
     */
    public static Date getFirstDayOfQuarter(int year, int quarter) {
        int month = 0;
        if (quarter > 4) {
            return null;
        } else {
            month = (quarter - 1) * 3 + 1;
        }
        return getFirstDayOfMonth(year, month);
    }
 
    /**
     * 得到某年某季度最后一天
     * @param year
     * @param quarter
     * @return
     */
    public static Date getLastDayOfQuarter(int year, int quarter) {
        int month = 0;
        if (quarter > 4) {
            return null;
        } else {
            month = quarter * 3;
        }
        return getLastDayOfMonth(year, month);
    }
 
    /**
     * 得到某年第一天
     * @param year
     * @return
     */
    public static Date getFirstDayOfYear(int year) {
        return getFirstDayOfQuarter(year, 1);
    }
 
    /**
     * 得到某年最后一天
     * @param year
     * @return
     */
    public static Date getLastDayOfYear(int year) {
        return getLastDayOfQuarter(year, 4);
    }
 
    /**
     * 得到某年某月的第一天
     * @param year
     * @param month
     * @return
     */
    public static Date getFirstDayOfMonth(int year, int month) {
        Calendar c = Calendar.getInstance();
        c.set(Calendar.YEAR, year);
        c.set(Calendar.MONTH, month - 1);
        c.set(Calendar.DAY_OF_MONTH, c.getActualMinimum(Calendar.DAY_OF_MONTH));
 
        return c.getTime();
    }
 
    /**
     * 获取某年某月某一周的第一天和最后一天（flag=true表示取第一天）
     * @param year
     * @param month
     * @param week
     * @param flag
     * @return
     */
    public static String getDayByWeek(int year, int month, int week,
            boolean flag) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month - 1);
        cal.set(Calendar.WEEK_OF_MONTH, week);
        int dw = cal.get(Calendar.DAY_OF_WEEK);
        if (!flag)
            cal.setTimeInMillis(cal.getTimeInMillis() + (8 - dw) * 24 * 60 * 60
                    * 1000);
        else
            cal.setTimeInMillis(cal.getTimeInMillis() - (dw - 2) * 24 * 60 * 60
                    * 1000);
        SimpleDateFormat formatter = new SimpleDateFormat(DATE_FORMAT);
        String showTime = formatter.format(cal.getTime());
        return showTime.toString();
    }
 
    public static String getStringToDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_FORMAT);
        return sdf.format(date);
    }
 
    /**
     * 转化字符串时间格式
     * @param strTime
     * @return
     * @throws ParseException
     */
    public static String formatTimeString(String strTime) throws ParseException {
        SimpleDateFormat getsdf = new SimpleDateFormat(EXACT_DATE_TIME_FORMAT);
        SimpleDateFormat resdf = new SimpleDateFormat("yyyy年MM月dd日");
        return resdf.format(getsdf.parse(strTime));
    }
 
    /**
     * 获取某一个月的周数
     * @param date
     * @throws ParseException 
     * @throws Exception
     */
    public static int getMonthWeek(String date) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(YEAR_MONTH_FORMAT);
        Date s = sdf.parse(date);
        Calendar ca = Calendar.getInstance();
        ca.setTime(s);
        ca.setFirstDayOfWeek(Calendar.MONDAY);
        int weeks = ca.getActualMaximum(Calendar.WEEK_OF_MONTH);
        return weeks;
    };
    
    
    public static String compareListStringDate(List<String> sList,String pattern){
		for(int i=1;i<sList.size();i++){
			if(compare_date(sList.get(i-1), sList.get(i), pattern) ==1){
				return Constants.CODE_VALUE_FAILURE;
			}
		}
		return Constants.CODE_VALUE_SUCCESS;
	}
    
    public static int compare_date(String DATE1, String DATE2,String pattern) {

		DateFormat df = new SimpleDateFormat(pattern);
		try {
			Date dt1 = df.parse(DATE1);
			Date dt2 = df.parse(DATE2);
			if (dt1.getTime() > dt2.getTime()) {
				return 1;
			} else if (dt1.getTime() < dt2.getTime()) {
				return -1;
			} else {
				return 0;
			}
		} catch (ParseException e) {
			e.printStackTrace();
			return 2;
		}
	}
    
    public static int compare_date(String DATE1, String DATE2) {
		DateFormat df = new SimpleDateFormat(DateTime.DATE_TIME_FORMAT);
		try {
			Date dt1 = df.parse(DATE1);
			Date dt2 = df.parse(DATE2);
			if (dt1.getTime() > dt2.getTime()) {
				return 1;
			} else if (dt1.getTime() < dt2.getTime()) {
				return -1;
			} else {
				return 0;
			}
		} catch (ParseException e) {
			e.printStackTrace();
			return 2;
		}
	}
    
    public static Date addDate(Date now, int day) {
		Calendar fromCal = Calendar.getInstance();
		Date returnDate = null;
		fromCal.setTime(now);
		fromCal.add(Calendar.DATE, day);
		returnDate = fromCal.getTime();
		return returnDate;
	}
	public static Date addMinute(Date now, int minute){
		Calendar fromCal = Calendar.getInstance();
		Date returnDate = null;
		fromCal.setTime(now);
		fromCal.add(Calendar.MINUTE, minute);
		returnDate = fromCal.getTime();
		return returnDate;
	}
}
