package com.hellokoding.account.model;

/**
 * Created by hanchen on 2016/10/30.
 */
public class Path {
    private String name;
    private String start;
    private String initial;
    private String end;
    private String destination;
    private String timeCost;
    private String startPointDescription;
    private String endPointDescription;

    public Path(String name, String start, String startName, String end, String endName, String timecost, String startPointDescription, String endPointDescription) {
        this.name = name;
        this.start = start;
        this.end = end;
        this.timeCost = timecost;
        this.initial = startName;
        this.destination = endName;
        this.startPointDescription = startPointDescription;
        this.endPointDescription = endPointDescription;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStart() {
        return start;
    }

    public void setStart(String start) {
        this.start = start;
    }

    public String getEnd() {
        return end;
    }

    public void setEnd(String end) {
        this.end = end;
    }

    public String getTimeCost() {
        return timeCost;
    }

    public void setTimeCost(String timeCost) {
        this.timeCost = timeCost;
    }

    public String getInitial() {
        return initial;
    }

    public void setInitial(String initial) {
        this.initial = initial;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public String getStartPointDescription() {
        return startPointDescription;
    }

    public void setStartPointDescription(String startPointDescription) {
        this.startPointDescription = startPointDescription;
    }

    public String getEndPointDescription() {
        return endPointDescription;
    }

    public void setEndPointDescription(String endPointDescription) {
        this.endPointDescription = endPointDescription;
    }
}
