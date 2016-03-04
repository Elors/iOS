package com.malalaoshi.android.pay;

import com.malalaoshi.android.entity.jsonBodyBase;

/**
 * Payer interface
 * Created by tianwei on 2/28/16.
 */
public interface Payer {
    void createOrder(jsonBodyBase body, ResultCallback<Object> callback);
    void createOrderInfo(String orderId, String channel, ResultCallback<Object> callback);
}