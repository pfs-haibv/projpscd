/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.pit.help.sources;

/**
 *
 * @author manhtv3
 */
public class HtmlPageNode {
    private HtmlPage page;
    private HtmlPageNode next;
    private HtmlPageNode previous;

    public HtmlPageNode() {
    }

    public HtmlPageNode(HtmlPage page, HtmlPageNode next, HtmlPageNode previous) {
        this.page = page;
        this.next = next;
        this.previous = previous;
    }

    public HtmlPageNode getNext() {
        return next;
    }

    public void setNext(HtmlPageNode next) {
        this.next = next;
    }

    public HtmlPage getPage() {
        return page;
    }

    public void setPage(HtmlPage page) {
        this.page = page;
    }

    public HtmlPageNode getPrevious() {
        return previous;
    }

    public void setPrevious(HtmlPageNode previous) {
        this.previous = previous;
    }

    
    
    
}
