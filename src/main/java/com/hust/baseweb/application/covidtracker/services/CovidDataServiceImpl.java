package com.hust.baseweb.application.covidtracker.services;

import com.hust.baseweb.application.covidtracker.models.CovidReponseModel;
import com.hust.baseweb.application.covidtracker.models.LocationStat;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class CovidDataServiceImpl implements CovidDataService {
    private static final String TOTALCASES_URL = "https://raw.githubusercontent" +
            ".com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series" +
            "/time_series_covid19_confirmed_global.csv";
    private static final String TOTALDEATHS_URL = "https://raw.githubusercontent" +
            ".com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series" +
            "/time_series_covid19_deaths_global.csv";
    private static final String TOTALRECOVERS_URL = "https://raw.githubusercontent" +
            ".com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series" +
            "/time_series_covid19_recovered_global.csv";

    private OkHttpClient client = new OkHttpClient();

    /**
     * Construct a GET request
     *
     * @param url
     * @return response body
     */
    public String getRequest(String url) throws IOException {
        Request request = new Request.Builder().url(url).build();
        Response response = client.newCall(request).execute();
        return response.body() != null ? response.body().string() : null;
    }

    public void writeToCSVFile(String filePath, String content) throws FileNotFoundException {
        PrintWriter writer = new PrintWriter(filePath);
        writer.print(content);
        writer.close();
    }

    @PostConstruct
    public void fetchData() throws IOException {   //executed after bean initialization.
        writeToCSVFile("covidreports/totalCases.csv", getRequest(TOTALCASES_URL));
        writeToCSVFile("covidreports/totalDeaths.csv", getRequest(TOTALDEATHS_URL));
        writeToCSVFile("covidreports/totalRecovers.csv", getRequest(TOTALRECOVERS_URL));
    }

    public List<LocationStat> getDataListLatestDay() throws IOException {
        List<LocationStat> dataList = new ArrayList<>();
        Reader casesReader = Files.newBufferedReader(Paths.get("covidreports/totalCases.csv"));
        Reader deathsReader = Files.newBufferedReader(Paths.get("covidreports/totalDeaths.csv"));
        Reader recoversReader = Files.newBufferedReader(Paths.get("covidreports/totalRecovers.csv"));

        CSVParser cases = CSVFormat.DEFAULT.withFirstRecordAsHeader().parse(casesReader);
        List<CSVRecord> deaths = CSVFormat.DEFAULT.withFirstRecordAsHeader().parse(deathsReader).getRecords();
        List<CSVRecord> recovers =
                CSVFormat.DEFAULT.withFirstRecordAsHeader().parse(recoversReader).getRecords();

        for (CSVRecord record : cases) {
            LocationStat locationStat = new LocationStat();
            locationStat.setCountry(record.get("Country/Region"));
            locationStat.setState(record.get("Province/State"));

            int latestCases = Integer.parseInt("0" + record.get(record.size() - 1));
            int prevDayCases = Integer.parseInt("0" + record.get(record.size() - 2));
            locationStat.setTotalCases(latestCases);
            locationStat.setDiffFromPrevDay(latestCases - prevDayCases);

            for (CSVRecord death : deaths) {
                if (death.get("Province/State").equals(record.get("Province/State"))
                        && death.get("Country/Region").equals(record.get("Country/Region"))) {
                    int latestDeaths = Integer.parseInt("0" + death.get(death.size() - 1));
                    locationStat.setTotalDeaths(latestDeaths);
                    break;
                }
            }

            for (CSVRecord recover : recovers) {
                if (recover.get("Province/State").equals(record.get("Province/State"))
                        && recover.get("Country/Region").equals(record.get("Country/Region"))) {
                    int latestRecovers = Integer.parseInt("0" + recover.get(recover.size() - 1));
                    locationStat.setTotalRecovers(latestRecovers);
                    break;
                }
            }
//            System.out.println(locationStat);
            dataList.add(locationStat);
            dataList.sort(Collections.reverseOrder());
        }
        return dataList;
    }

    public List<CovidReponseModel> getDataInMultipleDays(int days) throws IOException {
        List<CovidReponseModel> res = new ArrayList<>(); //Arrays.asList(new CovidReponseModel[days])
        for (int i = 0; i < days; i++) {
            LocalDate date = LocalDate.now().minusDays(i);
            res.add(new CovidReponseModel(0, 0, 0, 0, date));
        }

        Reader casesReader = Files.newBufferedReader(Paths.get("covidreports/totalCases.csv"));
        Reader deathsReader = Files.newBufferedReader(Paths.get("covidreports/totalDeaths.csv"));
        Reader recoversReader = Files.newBufferedReader(Paths.get("covidreports/totalRecovers.csv"));

        CSVParser cases = CSVFormat.DEFAULT.withFirstRecordAsHeader().parse(casesReader);
        List<CSVRecord> deaths = CSVFormat.DEFAULT.withFirstRecordAsHeader().parse(deathsReader).getRecords();
        List<CSVRecord> recovers =
                CSVFormat.DEFAULT.withFirstRecordAsHeader().parse(recoversReader).getRecords();

        for (CSVRecord record : cases)
            for (int i = 0; i < days; i++)
                res.get(i).setTotalCases(res.get(i).getTotalCases() + Integer.parseInt(record.get(record.size() - 1 - i)));

        for (CSVRecord record : deaths)
            for (int i = 0; i < days; i++)
                res.get(i).setTotalDeaths(res.get(i).getTotalDeaths() + Integer.parseInt(record.get(record.size() - 1 - i)));

        for (CSVRecord record : recovers)
            for (int i = 0; i < days; i++)
                res.get(i).setTotalRecovers(res.get(i).getTotalRecovers() + Integer.parseInt(record.get(record.size() - 1 - i)));

        Collections.reverse(res);
        return res;
    }

//    public static void main(String[] args) throws IOException { //testing purposes
//        CovidDataService service = new CovidDataService();
//        System.out.println(service.getDataInMultipleDays(7));
//    }

}
