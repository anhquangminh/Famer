class ChartModel {
  final String date;
  final int amount;

  ChartModel({ this.date, this.amount});

  ChartModel.fromJson(Map json)
      : date = json['Date'],
         amount = int.parse(json['Sum']);

  Map toJson() {
    return {
      'date': date,
      'amount': amount,
    };
  }
}
class ChartPie {
  final int total;
  final int sold;
  final int rest;

  ChartPie({ this.total, this.sold,this.rest});

  ChartPie.fromJson(Map json)
      : total = int.parse(json['Total']),
        sold = int.parse(json['Sold']),
        rest = json['Rest'];

  Map toJson() {
    return {
      'total': total,
      'sold': sold,
      'rest': rest,
    };
  }
}
