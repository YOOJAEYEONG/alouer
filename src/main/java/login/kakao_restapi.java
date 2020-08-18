package login;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class kakao_restapi {

	 public JsonNode getAccessToken(String autorize_code) {
	        
	        final String RequestUrl = "https://kauth.kakao.com/oauth/token";
	 
	        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
	        
	        //포스트 파라미터의 grant_type이라는 명칭에 authorization_code를 추가한다 아래도 동일
	        postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
	 
	        postParams.add(new BasicNameValuePair("client_id", "8bba638244771d9bc2d9e2480e608b8b"));
	 
	        postParams.add(new BasicNameValuePair("redirect_uri", "http://localhost:8282/alouer/oauth")); 
	 
	        postParams.add(new BasicNameValuePair("code", autorize_code));
	        
	        final HttpClient client = HttpClientBuilder.create().build();
	 
	        final HttpPost post = new HttpPost(RequestUrl);
	 
	        JsonNode returnNode = null;
	 
	        try {
	 
	            post.setEntity(new UrlEncodedFormEntity(postParams));
	 
	            final HttpResponse response = client.execute(post);
	 
	            ObjectMapper mapper = new ObjectMapper();
	 
	            returnNode = mapper.readTree(response.getEntity().getContent());
	 
	        } catch (UnsupportedEncodingException e) {
	 
	            e.printStackTrace();
	 
	        } catch (ClientProtocolException e) {
	 
	            e.printStackTrace();
	 
	        } catch (IOException e) {
	 
	            e.printStackTrace();
	 
	        } finally {
	 
	        }
	 
	        return returnNode;
	 
	    }

	 public JsonNode Logout(String autorize_code) {
	        final String RequestUrl = "https://kapi.kakao.com/v1/user/logout";
	 
	        final HttpClient client = HttpClientBuilder.create().build();
	 
	        final HttpPost post = new HttpPost(RequestUrl);
	 
	        post.addHeader("Authorization", "Bearer " + autorize_code);
	 
	        JsonNode returnNode = null;
	 
	        try {
	 
	            final HttpResponse response = client.execute(post);
	 
	            ObjectMapper mapper = new ObjectMapper();
	 
	            returnNode = mapper.readTree(response.getEntity().getContent());
	 
	        } catch (UnsupportedEncodingException e) {
	 
	            e.printStackTrace();
	 
	        } catch (ClientProtocolException e) {
	 
	            e.printStackTrace();
	 
	        } catch (IOException e) {
	 
	            e.printStackTrace();
	 
	        } finally {
	 
	        }
	 
	        return returnNode;
	 
	    }


	 
	 
	 
	 
	 
	 public static JsonNode getKakaoAccessToken(String code) {
		 
	        final String RequestUrl = "https://kauth.kakao.com/oauth/token"; // Host
	        final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
	 
	        postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
	        postParams.add(new BasicNameValuePair("client_id", "85f4a0fdfed755ce3d9b2b081af17f44")); // REST API KEY
	        postParams.add(new BasicNameValuePair("redirect_uri", "http://localhost:8080/MS/kakaologin")); // 리다이렉트 URI
	        postParams.add(new BasicNameValuePair("code", code)); // 로그인 과정중 얻은 code 값
	 
	        final HttpClient client = HttpClientBuilder.create().build();
	        final HttpPost post = new HttpPost(RequestUrl);
	 
	        JsonNode returnNode = null;
	 
	        try {
	            post.setEntity(new UrlEncodedFormEntity(postParams));
	 
	            final HttpResponse response = client.execute(post);
	            final int responseCode = response.getStatusLine().getStatusCode();
	 
	            System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
	            System.out.println("Post parameters : " + postParams);
	            System.out.println("Response Code : " + responseCode);
	 
	            // JSON 형태 반환값 처리
	            ObjectMapper mapper = new ObjectMapper();
	 
	            returnNode = mapper.readTree(response.getEntity().getContent());
	 
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        } catch (ClientProtocolException e) {
	            e.printStackTrace();
	        } catch (IOException e) {
	            e.printStackTrace();
	        } finally {
	        }
	 
	        return returnNode;
	    }




}
