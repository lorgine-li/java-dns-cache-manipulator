package com.alibaba.dcm.tool;

import java.net.InetAddress;
import java.util.Date;

/**
 * @author Jerry Lee (oldratlee at gmail dot com)
 */
public class MainForAgentInject {
    @SuppressWarnings({"InfiniteLoopStatement", "BusyWait"})
    public static void main(String[] args) throws Exception {
        while (true) {
            System.out.printf("%s: bing.com: %s\n", new Date(),
                    InetAddress.getByName("bing.com").getHostAddress());

            Thread.sleep(1000);
        }
    }
}
