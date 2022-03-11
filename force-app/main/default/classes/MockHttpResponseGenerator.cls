@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock
{
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"test": ""}');
        res.setStatusCode(200);
        return res;
    }
}