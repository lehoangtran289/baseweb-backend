package com.hust.baseweb.application.covidtracker.models;

import lombok.*;
import org.jetbrains.annotations.NotNull;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class LocationStat implements Comparable<LocationStat>{
    private String state;
    private String country;
    private int totalCases;
    private int totalDeaths;
    private int totalRecovers;
    private int diffFromPrevDay;

    @Override
    public int compareTo(@NotNull LocationStat o) {
        return Integer.compare(getTotalCases(), o.getTotalCases());
    }
}
