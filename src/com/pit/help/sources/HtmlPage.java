/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pit.help.sources;

import java.net.URL;

/**
 *
 * @author manhtv3
 */
public class HtmlPage {

    private URL url;

    public HtmlPage() {
        url = null;
    }

    public HtmlPage(URL url) {
        this.url = url;
    }

    public URL getUrl() {
        return url;
    }

    public void setUrl(URL url) {
        this.url = url;
    }
}
