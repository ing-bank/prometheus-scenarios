# PromQL Scenario

This is the right place if you want to learn basics of monitoring with Prometheus and Grafana.
You can run this scenario [here](https://www.katacoda.com/berny/scenarios/promql).

This scenario is divided in chapters which cover the following topics:
1. Chapter 1 - Grafana and PromQL basics 
    1. [Intro to Grafana and PromQL](chapter1/IntroGrafanaPromQL.md)
    1. [Grafana Panels](chapter1/PanelInfo.md)
    1. [PromQL Label Operators](chapter1/LabelOperators.md)
    1. [Templating Dashboards](chapter1/TemplatingDashboards.md)
1. Chapter 2 - PromQL
    1. [PromQL Functions](chapter2/UsingFunctions.md)
    1. [PromQL Aggregations](chapter2/Aggregations.md)
1. Chapter 3
    1. [PromQL Vector Operators](chapter3/Operators.md)
    1. [PromQL Filtering Vector Elements](chapter3/Filtering.md)
1. Chapter 4
    1. [Prometheus Summary and Histogram](chapter4/SummaryAndHistogram.md)
1. Chapter 5
    1. [PromQL Advanced Matching](chapter5/AdvancedMatching.md)

## Scenario Construction

As explained in the [Katacoda docs](https://www.katacoda.community/scenario-syntax.html#understanding-katacoda-s-index-json), 
the `index.json` describes the structure of the scenario. 

The Scenario is based on the [Katacoda Docker environment](https://www.katacoda.community/environments.html#deprecated-environments) which
consists of a single node that runs Docker. This is defined by the `"backend": { "imageid": "docker" }` field. 
When the scenario starts the `env-init.sh` script is executed. The script simply runs a `docker-compose up` command using 
[this compose file](assets/monitoring-apps.yml) which starts Grafana, Prometheus and an api that generates fake metrics.
Katacoda copies the `assets` folder to the live environment at startup as instructed by the `assets` field in the `index.json`. In this way
the `docker-compose.yml` becomes available to the `env-init.sh` script.
Once the containers are running, the apps become available to the student via automatically generated links,
see [here](https://www.katacoda.community/accessing-ports-ui.html#markdown-example) for more information.

The docker images for Prometheus and Grafana are pre-built with the configuration files in it. 
The build is done manually using the docker files are stored in the `docker` folder.

## How to add content

It's quite easy to add a new chapter or assignement. The content needs to be written into a Markdown file named after the topic.
Then the files need to be added in the `index.json` in the `steps` list. 
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