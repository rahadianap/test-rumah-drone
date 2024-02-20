<!doctype html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Invoice</title>
</head>
<body>
    <table class="w-full">
        <tr>
            <td class="w-half">
                <h2>Laporan Inventaris Gudang</h2>
            </td>
        </tr>
    </table>
 
    <div class="margin-top">
        <table class="products">
            <thead>
                <tr>
                    <th>Total Barang Masuk</th>
                    <th>Total Barang Keluar</th>
                </tr>
            </thead>
            <tbody>
                @foreach($data as $item)
                <tr class="items">
                        <td>
                            {{ $item['amount_in'] }}
                        </td>
                        <td>
                            {{ $item['amount_out'] }}
                        </td>
                    @endforeach
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>

<style>
    h4 {
    margin: 0;
}
.w-full {
    width: 100%;
}
.w-half {
    width: 50%;
}
.margin-top {
    margin-top: 1.25rem;
}
.footer {
    font-size: 0.875rem;
    padding: 1rem;
    background-color: rgb(241 245 249);
}
table {
    width: 100%;
    border-spacing: 0;
}
table.products {
    font-size: 0.875rem;
}
table.products tr {
    background-color: rgb(96 165 250);
}
table.products th {
    color: #ffffff;
    padding: 0.5rem;
    text-align: left
}
table.th {
    text-align: left
}
table tr.items {
    background-color: rgb(241 245 249);
}
table tr.items td {
    padding: 0.5rem;
}
.total {
    text-align: right;
    margin-top: 1rem;
    font-size: 0.875rem;
}
</style>