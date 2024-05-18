// To parse this JSON data, do
//
//     final eventData = eventDataFromJson(jsonString);

import 'dart:convert';

EventData eventDataFromJson(String str) => EventData.fromJson(json.decode(str));

String eventDataToJson(EventData data) => json.encode(data.toJson());

class EventData {
  final Request? request;
  final int? count;
  final List<Event>? eventList;

  EventData({
    this.request,
    this.count,
    this.eventList,
  });

  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
        request: json["request"] == null ? null : Request.fromJson(json["request"]),
        count: json["count"],
        eventList: json["item"] == null ? [] : List<Event>.from(json["item"]!.map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "request": request?.toJson(),
        "count": count,
        "item": eventList == null ? [] : List<dynamic>.from(eventList!.map((x) => x.toJson())),
      };
}

class Event {
  final String? eventId;
  final String? eventname;
  final String? eventnameRaw;
  final String? ownerId;
  final String? thumbUrl;
  final String? thumbUrlLarge;
  final int? startTime;
  final String? startTimeDisplay;
  final int? endTime;
  final String? endTimeDisplay;
  final String? location;
  final Venue? venue;
  final String? label;
  final int? featured;
  final String? eventUrl;
  final String? shareUrl;
  final String? bannerUrl;
  final double? score;
  final List<String>? categories;
  final List<String>? tags;
  final Tickets? tickets;
  final List<dynamic>? customParams;

  Event({
    this.eventId,
    this.eventname,
    this.eventnameRaw,
    this.ownerId,
    this.thumbUrl,
    this.thumbUrlLarge,
    this.startTime,
    this.startTimeDisplay,
    this.endTime,
    this.endTimeDisplay,
    this.location,
    this.venue,
    this.label,
    this.featured,
    this.eventUrl,
    this.shareUrl,
    this.bannerUrl,
    this.score,
    this.categories,
    this.tags,
    this.tickets,
    this.customParams,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventId: json["event_id"] ?? "",
        eventname: json["eventname"] ?? "",
        eventnameRaw: json["eventname_raw"] ?? "",
        ownerId: json["owner_id"] ?? "",
        thumbUrl: json["thumb_url"] ?? "",
        thumbUrlLarge: json["thumb_url_large"] ?? "",
        startTime: json["start_time"] ?? 0,
        startTimeDisplay: json["start_time_display"] ?? "",
        endTime: json["end_time"] ?? 0,
        endTimeDisplay: json["end_time_display"] ?? "",
        location: json["location"] ?? "",
        venue: json["venue"] == null ? Venue() : Venue.fromJson(json["venue"]),
        label: json["label"] ?? "",
        featured: json["featured"] ?? 0,
        eventUrl: json["event_url"] ?? "",
        shareUrl: json["share_url"] ?? "",
        bannerUrl: json["banner_url"] ?? "",
        score: json["score"]?.toDouble(),
        categories: json["categories"] == null ? [] : List<String>.from(json["categories"]!.map((x) => x)),
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        tickets: json["tickets"] == null ? null : Tickets.fromJson(json["tickets"]),
        customParams: json["custom_params"] == null ? [] : List<dynamic>.from(json["custom_params"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "eventname": eventname,
        "eventname_raw": eventnameRaw,
        "owner_id": ownerId,
        "thumb_url": thumbUrl,
        "thumb_url_large": thumbUrlLarge,
        "start_time": startTime,
        "start_time_display": startTimeDisplay,
        "end_time": endTime,
        "end_time_display": endTimeDisplay,
        "location": location,
        "venue": venue?.toJson(),
        "label": label,
        "featured": featured,
        "event_url": eventUrl,
        "share_url": shareUrl,
        "banner_url": bannerUrl,
        "score": score,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "tickets": tickets?.toJson(),
        "custom_params": customParams == null ? [] : List<dynamic>.from(customParams!.map((x) => x)),
      };
}

class Tickets {
  final bool? hasTickets;
  final String? ticketUrl;
  final String? ticketCurrency;
  final int? minTicketPrice;
  final int? maxTicketPrice;

  Tickets({
    this.hasTickets,
    this.ticketUrl,
    this.ticketCurrency,
    this.minTicketPrice,
    this.maxTicketPrice,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        hasTickets: json["has_tickets"] ?? "",
        ticketUrl: json["ticket_url"] ?? "",
        ticketCurrency: json["ticket_currency"] ?? "",
        minTicketPrice: json["min_ticket_price"] ?? 0,
        maxTicketPrice: json["max_ticket_price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "has_tickets": hasTickets,
        "ticket_url": ticketUrl,
        "ticket_currency": ticketCurrency,
        "min_ticket_price": minTicketPrice,
        "max_ticket_price": maxTicketPrice,
      };
}

class Venue {
  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final double? latitude;
  final double? longitude;
  final String? fullAddress;

  Venue({
    this.street,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.fullAddress,
  });

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        street: json["street"] ?? "",
        city: json["city"] ?? "",
        state: json["state"] ?? "",
        country: json["country"] ?? "",
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        fullAddress: json["full_address"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
        "latitude": latitude,
        "longitude": longitude,
        "full_address": fullAddress,
      };
}

class Request {
  final String? venue;
  final String? ids;
  final String? type;
  final String? city;
  final int? edate;
  final int? page;
  final String? keywords;
  final int? sdate;
  final String? category;
  final String? cityDisplay;
  final int? rows;

  Request({
    this.venue,
    this.ids,
    this.type,
    this.city,
    this.edate,
    this.page,
    this.keywords,
    this.sdate,
    this.category,
    this.cityDisplay,
    this.rows,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
        venue: json["venue"] ?? "",
        ids: json["ids"] ?? "",
        type: json["type"] ?? "",
        city: json["city"] ?? "",
        edate: json["edate"] ?? "",
        page: json["page"] ?? "",
        keywords: json["keywords"] ?? "",
        sdate: json["sdate"] ?? "",
        category: json["category"] ?? "",
        cityDisplay: json["city_display"] ?? "",
        rows: json["rows"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "venue": venue,
        "ids": ids,
        "type": type,
        "city": city,
        "edate": edate,
        "page": page,
        "keywords": keywords,
        "sdate": sdate,
        "category": category,
        "city_display": cityDisplay,
        "rows": rows,
      };
}
