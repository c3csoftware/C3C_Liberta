public interface IRestService 
{
    HTTPResponse setRequest(string req);

    void serviceCallback(string request, httpResponse response);
}