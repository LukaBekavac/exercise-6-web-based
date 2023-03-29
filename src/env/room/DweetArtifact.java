package room;
import cartago.Artifact;
import cartago.OPERATION;
import cartago.Artifact;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

import java.io.IOException;

/**
 * A CArtAgO artifact that provides an operation for sending messages to agents 
 * with KQML performatives using the dweet.io API
 */
public class DweetArtifact extends Artifact {
    String thingName = "was-LukaBiceps"; // replace with your actual thing name
    String data = "{\"hello\": \"world\"}"; // replace with your actual data



    public void getDweet() throws IOException {
        String apiUrl = "https://dweet.io/get/latest/dweet/for/" + thingName;

        HttpClient client = HttpClientBuilder.create().build();
        HttpGet request = new HttpGet(apiUrl);
        HttpResponse response = client.execute(request);

        String responseBody = EntityUtils.toString(response.getEntity());
        System.out.println(responseBody);
    }
    @OPERATION
    public void postDweet() throws IOException {
        String apiUrl = "https://dweet.io/dweet/for/" + thingName;

        HttpClient client = HttpClientBuilder.create().build();
        HttpPost request = new HttpPost(apiUrl);
        StringEntity entity = new StringEntity(data);
        request.setEntity(entity);
        request.setHeader("Content-Type", "application/json");

        HttpResponse response = client.execute(request);
        String responseBody = EntityUtils.toString(response.getEntity());

        System.out.println("Response: " + response.getStatusLine().getStatusCode());
        System.out.println("Body: " + responseBody);
    }

}






