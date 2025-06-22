function transform(SimpleOrder orderInput) returns OrderDetails => {
    date: orderInput.header?.date,
    orderId: orderInput.header?.orderId,
    orderStatus: false
};