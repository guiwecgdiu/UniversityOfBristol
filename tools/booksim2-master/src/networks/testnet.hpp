//testnet.hpp

#ifndef _TestNet_HPP_
#define _TestNet_HPP_

#include "network.hpp"
#include "routefunc.hpp"

class TestNet : public Network{
     
    int _a; //total # of routers
    int _p; //total # of processing nodes per router
    int _k; //total # of ports per router
        
    void _ComputeSize(const Configuration &config);
    void _BuildNet(const Configuration &config);

public:
    TestNet(const Configuration &config, const string &name);
    static void RegisterRoutingFunctions();
}; 


int testnet_port(int rID, int src, int dest);
void min_testnet(const Router *r, const Flit *f, int in_channel, OutputSet *outputs, bool inject);

#endif