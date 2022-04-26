function net = setup_net(net, divide_fcn, ...
    train_func, epochs_narx, trainRatio, valRatio, testRatio)

net.trainFcn = train_func;
net.trainParam.epochs = epochs_narx;
net.divideFcn = divide_fcn;
net.divideParam.trainRatio = trainRatio;
net.divideParam.valRatio = valRatio;
net.divideParam.testRatio = testRatio;

end

