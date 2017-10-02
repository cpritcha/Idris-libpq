module Main

import CFFI

%dynamic "/usr/local/opt/libpq/lib/libpq.dylib"
%include C  "/usr/local/opt/libpq/include/libpq-fe.h"
%lib C "pq"

pqConnectDb : String -> IO Ptr
pqConnectDb s
    = foreign FFI_C "PQconnectdb" (String -> IO Ptr) s

pqErrorMessage : String -> IO String
pqErrorMessage s
    = foreign FFI_C "PQerrorMessage" (String -> IO String) s

pqFinish : Ptr -> IO ()
pqFinish p
    = foreign FFI_C "PQfinish" (Ptr -> IO ()) p

pqStatus : Ptr -> IO Int
pqStatus p
    = foreign FFI_C "PQstatus" (Ptr -> IO Int) p

export data ConnectionStatus 
    = OK
    | BAD
    | STARTED
    | MADE
    | AWAITING_RESPONSE
    | AUTH_OK
    | SETENV
    | SSL_STARTUP
    | NEEDED
    | OTHER Int

mkConnectionStatus: Int -> ConnectionStatus
mkConnectionStatus i
    = case i of
        0 => OK
        1 => BAD
        2 => STARTED
        3 => MADE
        4 => AWAITING_RESPONSE
        5 => AUTH_OK
        6 => SETENV
        7 => SSL_STARTUP
        8 => NEEDED
        _ => OTHER i


Show ConnectionStatus where
    show x = case x of 
        OK => "OK"
        BAD => "BAD"
        STARTED => "STARTED"
        MADE => "MADE"
        AWAITING_RESPONSE => "AWAITING_RESPONSE"
        AUTH_OK => "AUTH_OK"
        SETENV => "SETENV"
        SSL_STARTUP => "SSL_STARTUP"
        NEEDED => "NEEDED"
        OTHER i => "OTHER " ++ show i

main : IO ()
main = do
    putStrLn "connecting to db"
    let connection = "host=localhost port=5432 dbname=idris user=idris"
    p <- pqConnectDb connection
    status <- pqStatus p
    putStr "connection status: "
    let statusMsg = mkConnectionStatus status
    putStrLn $ show statusMsg
    pqFinish p
    putStrLn "exiting"