# PromQL Scenario

This is the right place if you want to learn basics of monitoring with Prometheus and Grafana.

This scenario is divided in chapters which cover the following topics:
1. Chapter 1 - Grafana and PromQL basics 
    1. [Intro to Grafana and PromQL](chapter1/01-IntroGrafanaPromQL.md)
    1. [Grafana Panels](chapter1/02-PanelInfo.md)
    1. [PromQL Label Operators](chapter1/03-LabelOperators.md)
    1. [Templating Dashboards](chapter1/04-TemplatingDashboards.md)
1. Chapter 2 - PromQL
    1. [PromQL Functions](chapter2/01-UsingFunctions.md)
    1. [PromQL Aggregations](chapter2/02-Aggregations.md)
1. Chapter 3
    1. [PromQL Vector Operators](chapter3/01-Operators.md)
    1. [PromQL Filtering Vector Elements](chapter3/02-Filtering.md)
1. Chapter 4
    1. [Prometheus Summary and Histogram](chapter4/01-SummaryAndHistogram.md)
1. Chapter 5
    1. [PromQL Advanced Matching](chapter5/01-AdvancedMatching.md)


## Students

To follow this course, you will need a laptop with [Docker](https://www.docker.com/get-started) installed.

To start the learning environment, you need to execute the following commands.

For linux/mac:
```bash
$: cd path/to/promql/folder
$: export PROMQLWD="path/to/promql/folder"
$: docker-compose up
```

For Windows:
```
$: cd path\to\promql\folder
$: set PROMQLWD="path\\to\\promql\\folder"
$: docker-compose up
```

If everything went ok, you will be able to access the applications:
- Grafana [http://localhost:3000/](http://localhost:3000/)
- Prometheus [http://localhost:9090/](http://localhost:9090/)
- Textbook [http://localhost:3080/](http://localhost:3080/)

## How to add content

It's quite easy to add a new chapter or assignement. The content needs to be written into a Markdown file named after the topic.
When creating content consider these simple rules:
* keep things simple for the student
* split a chapter in multiple possibly small topics 
* the focus of each assignement should be on a specific result or learning objective (i.e. **Objective:** understand time series filtering)
* chapters and assignements should go from basic level to more advanced or expert level

New content should respect the format of the scenario:
1. state the objective at the beginning
1. explain the topic
1. write an assignement to let students put in practice what they read
1. provide a solution which is hidden by default, use the snippet below

```html
<details>
  <summary>Show solution</summary>

  **Solution**. You should have filled in: ```rate(api_request_count[1m])*10 > 150```
</details>
```