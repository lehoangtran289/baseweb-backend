package com.hust.baseweb.application.covidtracker.services;

import com.hust.baseweb.application.covidtracker.models.CovidReponseModel;
import com.hust.baseweb.application.covidtracker.models.LocationStat;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

public interface CovidDataService {

    String getRequest(String url) throws IOException;

    void writeToCSVFile(String filePath, String content) throws FileNotFoundException;

    List<LocationStat> getDataListLatestDay() throws IOException;

    List<CovidReponseModel> getDataInMultipleDays(int days) throws IOException;
}
