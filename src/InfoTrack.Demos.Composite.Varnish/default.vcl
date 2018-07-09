vcl 4.0;

backend default {
    .host = "10.0.2.2";
    .port = "80";
}

backend example {
    .host = "52.1.35.184";
    .port = "80";
}

sub vcl_recv {
    # Only a single backend
    set req.backend_hint = default;

    # Setting http headers for backend
    set req.http.X-Forwarded-For = client.ip;

    # Unset headers that might cause us to cache duplicate infos
    unset req.http.Accept-Language;
    unset req.http.User-Agent;

    # Drop cookies and params from static assets
    if (req.url ~ "\.(gif|jpg|jpeg|swf|ttf|css|js|flv|mp3|mp4|pdf|ico|png)(\?.*|)$") {
      unset req.http.cookie;
      set req.url = regsub(req.url, "\?.*$", "");
    }

    # Drop tracking params
    if (req.url ~ "\?(utm_(campaign|medium|source|term)|adParams|client|cx|eid|fbid|feed|ref(id|src)?|v(er|iew))=") {
      set req.url = regsub(req.url, "\?.*$", "");
    }

    # Redirect esi to the correct backend
    if (req.url ~ "^/ip") {
        set req.backend_hint = example;
        set req.http.host = "httpbin.org";
    } else {
        set req.backend_hint = default;
    }
}

sub vcl_backend_response {
  set beresp.do_esi = true;
}    