<#import "parts/common.ftl" as c>

<@c.page>
<div class="row my-3">
    <div class="col">
        <h4>Bootstrap 4 Chart.js - Line Chart</h4>
    </div>
</div>
<div class="row my-2">
    <div class="col-md-12">
        <div class="card">
            <div class="card-body">
                <canvas id="chLines" height="100"></canvas>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    /* chart.js chart examples */

    // chart colors
    var colors = ['#007bff','#28a745','#333333','#c3e6cb','#dc3545','#6c757d'];

    /* large line chart */
    var chLines = document.getElementById("chLines");
    var chartData = {
        labels: ["S", "M", "T", "W", "T", "F", "S"],
        datasets: [{
            data: [589, 445, 483, 503, 689, 692, 634],
            backgroundColor: 'transparent',
            borderColor: colors[0],
            borderWidth: 4,
            pointBackgroundColor: colors[0]
        },
            {
                data: [639, 465, 493, 478, 589, 632, 674],
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
        labels: ['Bootstrap', 'Popper', 'Other'],
        datasets: [
            {
                backgroundColor: colors.slice(0,3),
                borderWidth: 0,
                data: [74, 11, 40]
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
</script>
    </@c.page>