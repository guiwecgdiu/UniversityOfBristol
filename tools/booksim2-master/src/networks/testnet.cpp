//testnet.cpp

#include <sstream>

#include "booksim.hpp"
#include "testnet.hpp"
#include "random_utils.hpp"
#include "misc_utils.hpp"
#include "globals.hpp"

int gA_testnet, gP_testnet;

TestNet :: TestNet(const Configuration &config, const string &name) : Network(config, name)
{
    //cout << "testnet constructor starts ..." << endl;
    
    _ComputeSize(config);
    _Alloc();
    _BuildNet(config);
    
    //cout << "testnet constructor ends ..." << endl;
}

void TestNet :: _ComputeSize(const Configuration &config)    
{   
    //cout << "_ComputeSize starts ..." << endl;
     
    //hard-coding now, but can (and should) be fetched from the config file  
    _a = 8; //total # of routers
    _p = 4; //total # of processing nodes per router
    _k = (_a - 1) + _p; //total # of ports per router
                            
    //these three are variables declared in network.hpp and used in network.cpp
    _nodes = _a * _p;           //# of processing nodes
    _channels = _a * (_a-1);    //# of uni-directional link between the routers only 
                                        //(not processing nodes)
    _size = _a + _a*_p;         //# of nodes, including routers and processing nodes     
    
    gP_testnet = _p;            //global variables, needed for the routing functions
    gA_testnet = _a;      
    
    //cout << "_ComputeSize ends ..." << endl;                  
}

//Initialize router objects
void TestNet :: _BuildNet (const Configuration &config)
{
    //for every router  
        //build the router object
        //add the links to the processing nodes
        //add the links to the other routers
    
    ostringstream router_name;    
    int node;
    int c, cnt;
    int port_to_routers = _a - 1;
          
    for(node = 0; node < _a; node++){
        //create router
        router_name << "router";
        router_name << "_" << node;        
        _routers[node] = Router::NewRouter( config, this, router_name.str( ), 
					node, _k, _k );     //_k's are the # of input and output ports, respectively
		_timed_modules.push_back(_routers[node]);
		router_name.str("");

//Add links to the processing nodes  
        //add input and output channels to processing nodes
        for (cnt = 0; cnt < _p; cnt++ ) {
            c = _p * node +  cnt;   //for router 0, c is 0,1,2
                                    //for router 1, c is 3,4,5 
                                    // and so on.
            _routers[node]->AddInputChannel( _inject[c], _inject_cred[c] );
                                    // _inject and _inject_cred arrays are initialized in _alloc()
            
        }

        for (cnt = 0; cnt < _p; cnt++ ) {
            c = _p * node +  cnt;
            _routers[node]->AddOutputChannel( _eject[c], _eject_cred[c] );
            
        }   

//Add links to other routers       
        //add output and input channels to other routers
        for (cnt = 0; cnt < _a-1 ; cnt++){
            c = node * port_to_routers + cnt;
            _routers[node]->AddOutputChannel(_chan[c],_chan_cred[c]); 
        }           
                            /* So,  0 -> 0,1,2
                                    1 -> 3,4,5
                                    2 -> 6,7,8
                                    3 -> 9,10,11 */
        
        for(cnt = 0; cnt < _a; cnt++){
            if (cnt == node){
                continue;
                //do nothing
            }
            else if (cnt < node){
                c = cnt * port_to_routers -1 + node;
            }else if (cnt > node){
                c = cnt * port_to_routers + node; 
            }
            _routers[node] -> AddInputChannel(_chan[c],_chan_cred[c]);
            
        }
                            /* So,  0 ->   3,6,9
                                    1 -> 0,  7,10
                                    2 -> 1,4  11
                                    3 -> 2,5,8    */
    }
}

// the RegisterRouting function
void TestNet::RegisterRoutingFunctions(){

    gRoutingFunctionMap["min_testnet"] = &min_testnet;
}

// the Routing part 
//For a particular router, flit and input channel, need to provide: A output port and a output VC
//We wrote two functions: int testnet_port(int rID, int src, int dest) and void min_testnet( const Router *r, const Flit *f, int in_channel,  OutputSet *outputs, bool inject )

//Routing: to find the right port
int testnet_port(int rID, int src, int dest){
    int dst_router;
    int out_port;
    
    dst_router = dest / gP_testnet;
    
    //check if dest is under the same router as the current one
    if(rID == dst_router){
        //find the port that goes to the destination processing node
        out_port = dest % gP_testnet;
    }
    
    //else, dest in a different router that the current one
    else{
        if(dst_router < rID){
            out_port = gP_testnet + dst_router;  
                //example: current node: 2, dest 1. Then out_port = gP_testnet + 1 = 4 
                //[port 0,1,2 goes to processing nodes, port 3, 4 to routers 0,1. Port 5 to router 3.];
        }else{
            out_port = gP_testnet + dst_router - 1;
        }
    }
    
    return out_port;
}

//Routing: Minimal routing function
void min_testnet( const Router *r, const Flit *f, int in_channel, 
		       OutputSet *outputs, bool inject )
{
    int debug = f-> watch;
    
    outputs -> Clear();
    
    if(inject){
        int inject_vc = RandomInt(gNumVCs - 1);
                    //int gNumVCs; declared in routefunc.cpp
                    //value provided by the user in the config file, through "num_vcs"
        outputs->AddRange(-1,inject_vc,inject_vc);
        return;
    }
    
    int rID = r->GetID();
    
    int out_port = -1;
    int out_vc = 0;

    //cases:
        //1. It can be source node, assign it to VC 0
        //2. It can be dest node, assign it to VC 1    
        
    if (in_channel < gP_testnet){
        out_vc = 0; 
    }else{
        out_vc = 1;
    }
    
    out_port = testnet_port(rID,f->src,f->dest);
    
    outputs->AddRange( out_port, out_vc, out_vc );
    
    if (debug)
    *gWatchOut << GetSimTime() << " | " << r->FullName() << " | "
	       << "	through output port : " << out_port 
	       << " out vc: " << out_vc << endl;
}
