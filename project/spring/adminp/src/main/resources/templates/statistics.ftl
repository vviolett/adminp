<#import "parts/common.ftl" as c>

<@c.page>
<div class="row my-3">
    <div class="col">
        <h4>Распределение задач по проектам</h4>
    </div>
    <div class="col">
        <h4>Распределение задач по сотрудникам</h4>
    </div>
</div>
<div class="row my-2">
    <div class="col-md-6">
        <div class="card">
            <div class="card-body">
                <canvas id="chLines" width="800" height="450"></canvas>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card">
            <div class="card-body">
                <canvas id="doughnut-chart" width="800" height="450"></canvas>
            </div>
        </div>
    </div>
</div>
</div>
<script>

    new Chart(document.getElementById("doughnut-chart"), {
        type: 'doughnut',
        data: {
            labels: [<#list users as user>'${user.username}',</#list>],
            datasets: [
                {
                    backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#e37b00","#c0c403","#c44f63","#9126c4","#00c4c3"],
                    data: [<#list users as user>${user.countTasksForExecution()},</#list>]
                }
            ]
        },
        options: {
            title: {
                display: false,
                text: 'Predicted world population (millions) in 2050'
            }
        }
    });

    /* chart.js chart examples */
    // chart colors
    var colors = ['#007bff','#28a745','#333333','#c3e6cb','#dc3545','#6c757d'];
    /* large line chart */
    var chLines = document.getElementById("chLines");
    var chartData = {
        labels: [<#list projects as project>'${project.text}',</#list>],
        datasets: [{
            data: [<#list projects as project>${project.countTasks()},</#list>],
            backgroundColor: colors[3],
            borderColor: colors[1],
            borderWidth: 4,
            pointBackgroundColor: colors[1]
        }]
    };

    if (chLines) {
        new Chart(chLines, {
            type: 'line',
            data: chartData,
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: false
                        }
                    }]
                },
                legend: {
                    display: false
                }
            }
        });
    }
</script>

<div class="container">
    <div class="row my-3">
        <div class="col">
            <h4>Bootstrap 4 Chart.js</h4>
        </div>
    </div>
    <div class="row py-2">
        <div class="col-md-4 py-1">
            <div class="card">
                <div class="card-body">
                    <canvas id="chDonut1"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-4 py-1">
            <div class="card">
                <div class="card-body">
                    <canvas id="chDonut2"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-4 py-1">
            <div class="card">
                <div class="card-body">
                    <canvas id="chDonut3"></canvas>
                </div>
            </div>
        </div>
        <div class="col-md-4 py-1">
            <div class="card">
                <div class="card-body">
                    <canvas id="chDonut4"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    /* chart.js chart examples */

    // chart colors
    var colors = ['#007bff','#28a745','#333333','#c3e6cb','#dc3545','#6c757d'];

    /* 3 donut charts */
    var donutOptions = {
        cutoutPercentage: 85,
        legend: {position:'bottom', padding:5, labels: {pointStyle:'circle', usePointStyle:true}}
    };

    // donut 1
    var chDonutData1 = {
        labels: [<#list users as user>'${user.username}',</#list>],
        datasets: [
            {
                backgroundColor: colors.slice(0,3),
                borderWidth: 0,
                data: [<#list users as user>${user.countTasksForExecution()},</#list>]
            }
        ]
    };

    var chDonut1 = document.getElementById("chDonut1");
    if (chDonut1) {
        new Chart(chDonut1, {
            type: 'pie',
            data: chDonutData1,
            options: donutOptions
        });
    }

    // donut 2
    var chDonutData2 = {
        labels: ['Wips', 'Pops', 'Dags'],
        datasets: [
            {
                backgroundColor: colors.slice(0,3),
                borderWidth: 0,
                data: [40, 45, 30]
            }
        ]
    };
    var chDonut2 = document.getElementById("chDonut2");
    if (chDonut2) {
        new Chart(chDonut2, {
            type: 'pie',
            data: chDonutData2,
            options: donutOptions
        });
    }

    // donut 3
    var chDonutData3 = {
        labels: ['Angular', 'React', 'Other'],
        datasets: [
            {
                backgroundColor: colors.slice(0,3),
                borderWidth: 0,
                data: [21, 45, 55, 33]
            }
        ]
    };
    var chDonut3 = document.getElementById("chDonut3");
    if (chDonut3) {
        new Chart(chDonut3, {
            type: 'pie',
            data: chDonutData3,
            options: donutOptions
        });
    }

    var chDonut4 = document.getElementById("chDonut4");
    new Chart(chDonut4, {
        type: 'bar',
        data: chDonutData3,
        options: donutOptions
    });
</script>
    </@c.page>