
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.util.EntityUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * 
 * @author H__D
 * @date 2016年10月19日 上午11:27:25
 *
 */
public class HttpClientUtil extends HttpServlet {

    private static final long serialVersionUID = -1915463532411657451L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            // Write some content

            System.out.println("执行了-------------");
            String checkInDate = (String)request.getParameter("checkInDate");
            String checkOutDate = (String)request.getParameter("checkOutDate");
            String regionId = (String)request.getParameter("regionId");

            checkInDate = checkInDate.replaceAll("-","");
            checkOutDate = checkOutDate.replaceAll("-","");
            System.out.println(regionId + " ," + checkInDate+ " ," + checkOutDate);

//            student stu = new student();
//            stu.setAge(18);
//            stu.setName("zhangsan");
            JSONArray arr=JSONArray.fromObject(httpGet(regionId,checkInDate,checkOutDate));
            System.out.println(arr.toString());
//            PrintWriter out = response.getWriter();
            out.println(arr.toString());
            out.flush();
            out.close();
        } finally {
            out.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response) throws ServletException, IOException {
        //Do some other work
    }

    @Override
    public String getServletInfo() {
        return "MyServlet";
    }

    private JSONObject httpGet(String regionId,String checkInDate,String checkOutDate){

        JSONObject jsonResult = null;
        try {
            DefaultHttpClient client = new DefaultHttpClient();

//            checkInDate = "20170415";
//            checkOutDate = "20170420";
            String url = "http://localhost:8080/regioninsights?regionId="+regionId+"&checkInDate="+checkInDate+"&checkOutDate="+checkOutDate;
            HttpGet request = new HttpGet(url);
            request.setHeader("Content-Type","application/json");
            HttpResponse response = client.execute(request);


            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {

                String strResult = EntityUtils.toString(response.getEntity());
                System.out.println("strResult="+strResult);
//                strResult = "{\"employees\": [{\"firstName\": \"Bill\",\"lastName\": \"Gates\"},{\"firstName\": \"George\",\"lastName\": \"Bush\"}]}";
                jsonResult = JSONObject.fromObject(strResult);
                System.out.println("jsonResult="+jsonResult);
            } else {
//                epcLogger.error(SystemEvent.NEWSFEED_CURRENCY_RATE_CONNECTOR_RESPONSE_CDE_ERROR,"status cde is [ "+ response.getStatusLine().getStatusCode()  +" ]" );
            }
        } catch (IOException e) {
//            epcLogger.error(SystemEvent.NEWSFEED_CURRENCY_RATE_CONNECTOR_IO_ERROR,"IOException is :"+e.getMessage());

        }
        return jsonResult;
    }

}