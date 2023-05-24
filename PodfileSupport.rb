# Global Properties
$localRepository = '../'
$remoteRepository = 'https://github.com/andrecampopiano'
# Methods
def setup(mod:, path:, branch: 'main', local: false)
  if ($localSource || local)
    setupLocalRepository(mod, path)
  else
    setupRemoteRepository(mod, path, branch)
  end
end

def setupRemoteRepository(mod, path, branch)
  pod mod, :git => $remoteRepository + path, :branch => branch
end

def setupLocalRepository(mod, path)
  pod mod, :path => $localRepository + path
end
