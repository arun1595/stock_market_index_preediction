
	%Load data matrix

	fprintf('Reading nifty data...\n');
	data_read = csvread('nifty50.csv');
	fprintf(strcat("Read", num2str(size(data_read, 1)), " rows"));

	% Skip the date column, volume and change%
	% Skip the first row since it contains the column headers

	fprintf('\nPreprocessing...\n');
	data = data_read(2:size(data_read, 1),:);
	size(data)
	
	% Compute the feature vector from the data

	featureVector = computeFeatures(data, 10);
	sz = size(featureVector)
	fprintf("Writing feature vector to CSV....\n")
	headers = ['SMA,EMA,Momentum,StochasticK,StochasticD,CCI,ADO,R,RSI,MACD,ClosingPrice'];
	outid = fopen('nifty50_features.csv', 'w+');
	fprintf(outid, '%s', headers);
	fclose(outid);
	size(featureVector)
	
	closing_price = data_read(2:size(data_read,1),1);

	%Change order of closing prices to match prices after 10 days
	closing_price = shift(closing_price, 10);
	for i=1:10
		closing_price(i) = mean(closing_price(1:10,1));
	end

	fprintf("Size of closing prices\n")
	size(closing_price)
	featureVector = [featureVector closing_price];
	fprintf("Added closing prices to data\n")
	size(featureVector)
	
	dlmwrite('nifty50_features.csv',featureVector,'delimiter',',','roffset',1,'-append')

	%fprintf("Preparing test data\n")
	%test_data = csvread('input.csv');

	%test_data = test_data(2:size(test_data, 1), 3:6);
	%size(test_data)
	%test_data(1:10,:)

	%testVector = computeFeatures(test_data, 10);
	%csvwrite('test.csv',testVector);
	%fprintf("Done");


