package com.wxc.httputil;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.net.ssl.SSLContext;

import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.ParseException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContextBuilder;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSON;

/**
 * ClassName:HttpUtil <br/>
 * Function: http请求工具�? <br/>
 * Reason: TODO ADD REASON. <br/>
 * Date: 2016�?1�?21�? 下午6:52:13 <br/>
 * 
 * @author bxy-jing
 * @version
 * @since JDK 1.6
 * @see
 */
public class HttpUtil {

	private static final Logger logger = LoggerFactory.getLogger(HttpUtil.class);

	public static final String DEFAULT_CHARSET = "utf-8";

	/**
	 * 
	 * get:使用httpClient发�?�get请求. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response get(String url) {
		return get(url, null, null, DEFAULT_CHARSET);
	}

	/**
	 * 
	 * get:使用httpClient发�?�get请求. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param params
	 *            参数
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response get(String url, Map<String, String> params) {
		return get(url, params, null, DEFAULT_CHARSET);
	}

	/**
	 * 
	 * get:使用httpClient发�?�get请求. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param params
	 *            参数
	 * @param headers
	 *            请求�?
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response get(String url, Map<String, String> params, Map<String, String> headers) {
		return get(url, params, headers, DEFAULT_CHARSET);
	}

	/**
	 * 
	 * post:使用httpClient发�?�post请求. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param params
	 *            参数
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response post(String url, Map<String, String> params) {
		return post(url, params, null, DEFAULT_CHARSET);
	}

	/**
	 * 
	 * postJson:使用httpClient发�?�post json请求 . <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param object
	 *            �?要传递的对象
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response postJson(String url, Object object) {
		return postJson(url, object, null, DEFAULT_CHARSET);
	}

	/**
	 * 
	 * postJson:使用httpClient发�?�post json请求 . <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param object
	 *            �?要传递的对象
	 * @param headers
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response postJson(String url, Object object, Map<String, String> headers) {
		return postJson(url, object, headers, DEFAULT_CHARSET);
	}

	/**
	 * 
	 * postJson:使用httpClient发�?�post json请求 . <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param object
	 *            �?要传递的对象
	 * @param headers
	 * @param charset
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response postJson(String url, Object object, Map<String, String> headers, String charset) {
		if (null == headers) {
			headers = new HashMap<String, String>();
		}
		headers.put("Content-Type", "application/json");
//		headers.put("Content-Type", "application/x-www-form-urlencoded");
		String data = JSON.toJSONString(object);
		return postStr(url, data, headers, charset);
	}

	/**
	 * 
	 * post:使用httpClient发�?�post请求. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param params
	 *            参数
	 * @param headers
	 *            请求�?
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response post(String url, Map<String, String> params, Map<String, String> headers) {
		return post(url, params, headers, DEFAULT_CHARSET);
	}
	public static Response post1(String url, Map<String, String> params, Map<String, String> headers) {
		return post1(url, params, headers, DEFAULT_CHARSET);
	}
	/**
	 * 
	 * postStr:使用httpClient发�?�post请求. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param data
	 *            post数据
	 * @param headers
	 *            请求�?
	 * @param charset
	 *            编码格式
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response postStr(String url, String data, Map<String, String> headers, String charset) {
		logger.debug("post-send|url>>>{}|data>>>{}|headers>>>{}", url, data, headers);
		curlLog( url,  data,  headers,"POST");
		long startTime = System.currentTimeMillis();
		Response response = new Response();
		CloseableHttpClient client = createClient(url);
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeaders(map2Headers(headers));
		CloseableHttpResponse httpResponse = null;
		try {
			StringEntity stringEntity = new StringEntity(data, charset);
			httpPost.setEntity(stringEntity);
			httpResponse = client.execute(httpPost);
			response = formatResponse(httpResponse, charset);
		} catch (ClientProtocolException e) {
			response.setReasonPhrase(e.getMessage());
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			response.setReasonPhrase(e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			response.setReasonPhrase(e.getMessage());
			e.printStackTrace();
		} finally {
			close(client, httpResponse);
		}
		long endTime = System.currentTimeMillis();
		logger.debug("post-response|url>>>{}|used>>>{}ms|response>>>{}", url, endTime - startTime,
				JSON.toJSONString(response));

		return response;
	}

	
	private static void curlLog(String url, String data, Map<String, String> headers,String method){
		StringBuilder sb = new StringBuilder();
		sb.append("curl -X "+method+" \\ \n");
		if(null!=headers&&!headers.isEmpty()){
			for(String key:headers.keySet()){
				sb.append("-H '"+key+": "+headers.get(key)+"' \\ \n");
			}
		}
		if(null!=data){
			sb.append("-d '"+data+"' \\ \n");
		}
		sb.append("'"+url+"'");
		System.out.println(sb.toString());
	}
	/**
	 * 
	 * post:使用httpClient发�?�post请求. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param params
	 *            参数
	 * @param headers
	 *            请求�?
	 * @param charset
	 *            编码格式
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response post(String url, Map<String, String> params, Map<String, String> headers, String charset) {
		String paramsStr = URLEncodedUtils.format(map2NameValuePairs(params), charset);
		if (null == headers) {
			headers = new HashMap<String, String>();
		}
		headers.put("Content-Type", "application/x-www-form-urlencoded");
		return postStr(url, paramsStr, headers, charset);
	}
	public static Response post1(String url, Map<String, String> params, Map<String, String> headers, String charset) {
		net.sf.json.JSONObject js = net.sf.json.JSONObject.fromObject(params);
		
		String paramsStr = js.toString();/*URLEncodedUtils.format(map2NameValuePairs(params), charset); */
		if (null == headers) {
			headers = new HashMap<String, String>();
		}
		headers.put("Content-Type", "application/json");
		return postStr(url, paramsStr, headers, charset);
	}
	/**
	 * 
	 * get:使用httpClient发�?�get请求. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param params
	 *            参数
	 * @param headers
	 *            请求�?
	 * @param charset
	 *            编码格式
	 * @return Response
	 * @since JDK 1.6
	 */
	public static Response get(String url, Map<String, String> params, Map<String, String> headers, String charset) {
		logger.debug("get-send|url>>>{}|params>>>{}|headers>>>{}", url, params, headers);
		long startTime = System.currentTimeMillis();
		Response response = new Response();
		CloseableHttpClient client = createClient(url);
		if (null != params && !params.isEmpty()) {
			if (url.indexOf("?") == -1) {
				url += "?";
			}
			String paramsStr = URLEncodedUtils.format(map2NameValuePairs(params), charset);
			if (!url.endsWith("?")) {
				url += "&";
			}
			url += paramsStr;
		}
		curlLog(url,null,headers,"GET");
		HttpGet httpGet = new HttpGet(url);
		httpGet.setHeaders(map2Headers(headers));
		CloseableHttpResponse httpResponse = null;
		try {
			httpResponse = client.execute(httpGet);
			response = formatResponse(httpResponse, charset);
		} catch (IOException e) {
			response.setReasonPhrase(e.getMessage());
			e.printStackTrace();

		}
		long endTime = System.currentTimeMillis();
		logger.debug("get-response|url>>>{}|used>>>{}ms|response>>>{}", url, endTime - startTime,
				JSON.toJSONString(response));
		return response;
	}

	/**
	 * 
	 * upload:httpClient上传文件. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param files
	 *            文件map
	 * @return
	 * @since JDK 1.6
	 */
	public static Response upload(String url, Map<String, String> files) {
		return upload(url, files, null);
	}

	/**
	 * 
	 * upload:httpClient上传文件. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param files
	 *            文件map
	 * @param params
	 *            其他参数
	 * @return
	 * @since JDK 1.6
	 */
	public static Response upload(String url, Map<String, String> files, Map<String, String> params) {
		return upload(url, files, params, null);
	}

	/**
	 * 
	 * upload:httpClient上传文件. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param files
	 *            文件map
	 * @param params
	 *            其他参数
	 * @param headers
	 *            头文�?
	 * @return
	 * @since JDK 1.6
	 */
	public static Response upload(String url, Map<String, String> files, Map<String, String> params,
			Map<String, String> headers) {
		return upload(url, files, params, headers, DEFAULT_CHARSET);
	}

	/**
	 * 
	 * upload:httpClient上传文件. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @param files
	 *            文件map
	 * @param params
	 *            其他参数
	 * @param headers
	 *            头文�?
	 * @param charset
	 * @return
	 * @since JDK 1.6
	 */
	public static Response upload(String url, Map<String, String> files, Map<String, String> params,
			Map<String, String> headers, String charset) {
		logger.debug("upload-send|url>>>{}|files>>>{}|params>>>{}|headers>>>{}", url, files, params, headers);
		long startTime = System.currentTimeMillis();
		Response response = new Response();
		CloseableHttpClient client = createClient(url);
		HttpPost httpPost = new HttpPost(url);
		httpPost.setHeaders(map2Headers(headers));
		CloseableHttpResponse httpResponse = null;
		try {
			MultipartEntityBuilder builder = MultipartEntityBuilder.create();
			builder.setCharset(Charset.forName(charset));
			if (null != files && !files.isEmpty()) {
				for (Entry<String, String> entry : files.entrySet()) {
					builder.addPart(entry.getKey(), new FileBody(new File(entry.getValue())));
				}
			}
			if (null != params && !params.isEmpty()) {
				for (Entry<String, String> entry : params.entrySet()) {
					builder.addTextBody(entry.getKey(), entry.getValue(), ContentType.TEXT_PLAIN);
				}
			}
			HttpEntity entity = builder.build();
			httpPost.setEntity(entity);
			httpResponse = client.execute(httpPost);
			response = formatResponse(httpResponse, charset);
		} catch (Exception e) {
			response.setReasonPhrase(e.getMessage());
			e.printStackTrace();
		} finally {
			close(client, httpResponse);
		}

		long endTime = System.currentTimeMillis();
		logger.debug("upload-response|url>>>{}|used>>>{}ms|response>>>{}", url, endTime - startTime,
				JSON.toJSONString(response));
		return response;
	}

	private static List<NameValuePair> map2NameValuePairs(Map<String, String> map) {
		List<NameValuePair> formParams = new ArrayList<NameValuePair>();
		if (null != map && !map.isEmpty()) {
			for (Entry<String, String> param : map.entrySet()) {
				formParams.add(new BasicNameValuePair(param.getKey(), param.getValue()));
			}
		}
		return formParams;
	}

	/**
	 * 
	 * formatResponse:将CloseableHttpResponse转换成自定义Response对象. <br/>
	 *
	 * @author bxy-jing
	 * @param httpResponse
	 * @param charset
	 * @return
	 * @throws ParseException
	 * @throws IOException
	 * @since JDK 1.6
	 */
	private static Response formatResponse(CloseableHttpResponse httpResponse, String charset)
			throws ParseException, IOException {
		Response response = new Response();
		int statusCode = httpResponse.getStatusLine().getStatusCode();
		String reasonPhrase = httpResponse.getStatusLine().getReasonPhrase();
		HttpEntity entity = httpResponse.getEntity();
		Header[] retHeaders = httpResponse.getAllHeaders();
		String body = EntityUtils.toString(entity, charset);
		response.setStatusCode(statusCode);
		response.setReasonPhrase(reasonPhrase);
		response.setBody(body);
		response.setHeaders(headers2Map(retHeaders));
		return response;
	}

	/**
	 * 
	 * headers2Map:header数组转map. <br/>
	 *
	 * @author bxy-jing
	 * @param headers
	 *            header数组
	 * @return map
	 * @since JDK 1.6
	 */
	private static Map<String, String> headers2Map(Header[] headers) {
		Map<String, String> map = new HashMap<String, String>();
		if (null != headers && headers.length > 0) {
			for (Header header : headers) {
				map.put(header.getName(), header.getValue());
			}
		}
		return map;
	}

	/**
	 * 
	 * map2Headers:map对象转Header数组 <br/>
	 *
	 * @author bxy-jing
	 * @param map
	 *            map对象
	 * @return Header数组
	 * @since JDK 1.6
	 */
	private static Header[] map2Headers(Map<String, String> map) {
		if (null != map && !map.isEmpty()) {
			int size = map.size();
			Header[] headers = new Header[size];
			int i = 0;
			for (Entry<String, String> entry : map.entrySet()) {
				headers[i] = new BasicHeader(entry.getKey(), entry.getValue());
				i++;
			}
			return headers;
		} else {
			return new Header[] {};
		}
	}

	/**
	 * 
	 * close:关闭链接 <br/>
	 *
	 * @author bxy-jing
	 * @param client
	 * @param response
	 * @since JDK 1.6
	 */
	private static void close(CloseableHttpClient client, CloseableHttpResponse response) {
		if (null != response) {
			try {
				response.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if (null != client) {
			try {
				client.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 
	 * createClient:根据url创建对应的httpClient（http/https�?. <br/>
	 *
	 * @author bxy-jing
	 * @param url
	 * @return
	 * @since JDK 1.6
	 */
	public static CloseableHttpClient createClient(String url) {
		CloseableHttpClient client;
		if (url.toLowerCase().startsWith("https://")) {
			client = createSSLClientDefault();
		} else {
			client = createClientDefault();
		}
		return client;
	}

	/**
	 * 
	 * createClientDefault:创建http httpClient. <br/>
	 *
	 * @author bxy-jing
	 * @return
	 * @since JDK 1.6
	 */
	public static CloseableHttpClient createClientDefault() {
		CloseableHttpClient client = HttpClients.createDefault();
		return client;
	}

	/**
	 * 
	 * createSSLClientDefault:创建https httpClient <br/>
	 *
	 * @author bxy-jing
	 * @return
	 * @since JDK 1.6
	 */
	public static CloseableHttpClient createSSLClientDefault() {
		CloseableHttpClient client = null;
		try {
			SSLContext sslContext = null;
			sslContext = new SSLContextBuilder().loadTrustMaterial(null, new TrustStrategy() {
				@Override
				public boolean isTrusted(X509Certificate[] chain, String authType) throws CertificateException {
					return true;
				}
			}).build();
			SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslContext);
			client = HttpClients.custom().setSSLSocketFactory(sslsf).build();
		} catch (NoSuchAlgorithmException | KeyStoreException | KeyManagementException e) {
			e.printStackTrace();
		}
		return client;
	}	
}
